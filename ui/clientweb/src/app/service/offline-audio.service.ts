import { Injectable, inject } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import Hls from 'hls.js';
import { openDB, IDBPDatabase } from 'idb';
import { Track } from './audio.service';

interface VideoDB {
  playlists: { id: string; content: string };
  segments: { id: string; blob: Blob };
  keys: { id: string; blob: Blob };
}

interface OfflineTrack extends Track {
  isOffline: true;
  offlineKey: string;
  dateAdded: number;
}

@Injectable({
  providedIn: 'root'
})
export class OfflineAudioService {
  private offlineTracksSubject = new BehaviorSubject<Track[]>([]);
  offlineTracks$ = this.offlineTracksSubject.asObservable();

  private dbPromise: Promise<IDBPDatabase<VideoDB>>;

  constructor() {
    this.dbPromise = openDB<VideoDB>('video-store', 1, {
      upgrade(db) {
        db.createObjectStore('playlists', { keyPath: 'id' });
        db.createObjectStore('segments', { keyPath: 'id' });
        db.createObjectStore('keys', { keyPath: 'id' });
      }
    });

    this.loadOfflineTracks();
  }

  private async getDB() {
    return await this.dbPromise;
  }

  private loadOfflineTracks(): void {
    try {
      const offlineTracksJson = localStorage.getItem('offlineTracks');
      if (offlineTracksJson) {
        const offlineTracks = JSON.parse(offlineTracksJson) as Track[];
        this.offlineTracksSubject.next(offlineTracks);
      } else {
        this.offlineTracksSubject.next([]);
      }
    } catch (error) {
      console.error('Error loading offline tracks:', error);
      this.offlineTracksSubject.next([]);
    }
  }

  private saveOfflineTracksToStorage(tracks: Track[]): void {
    try {
      localStorage.setItem('offlineTracks', JSON.stringify(tracks));
    } catch (error) {
      console.error('Error saving offline tracks to storage:', error);
    }
  }

  private parseSegmentUrls(
    m3u8Content: string,
    baseUrl: string
  ): { segmentItems: { url: string; name: string }[]; keyUri: string | null } {
    const lines = m3u8Content.split('\n');
    const segmentItems: { url: string; name: string }[] = [];
    let keyUri: string | null = null;

    for (const line of lines) {
      if (line.startsWith('#EXT-X-KEY')) {
        const match = /URI="([^"]+)"/.exec(line);
        if (match) keyUri = match[1];
      }

      if (line.trim().length > 0 && !line.startsWith('#') && (line.endsWith('.ts') || line.includes('.ts?'))) {
        const fullUrl = line.startsWith('http') ? line : baseUrl + line.trim();
        segmentItems.push({
          url: fullUrl,
          name: line.trim()
        });
      }
    }

    return { segmentItems, keyUri };
  }

  getAllOfflineTracks(): Observable<Track[]> {
    return this.offlineTracks$;
  }

  isTrackSavedOffline(trackId: string): boolean {
    return this.offlineTracksSubject.value.some((track) => track.id === trackId);
  }

  async saveTrackForOffline(track: Track): Promise<boolean> {
    try {
      if (this.isTrackSavedOffline(track.id)) {
        return true; // Already saved
      }

      console.log('Saving track for offline:', track);

      if (track.isM3u8) {
        // Save M3U8 playlist and segments
        await this.savePlaylistAndSegments(track.id, track.audioUrl);

        // Create offline track data
        const offlineTrack: Track = {
          ...track,
          isOffline: true,
          offlineKey: track.id,
          dateAdded: Date.now()
        };

        // Add to offline tracks list
        const currentTracks = this.offlineTracksSubject.value;
        const updatedTracks = [...currentTracks, offlineTrack];
        this.offlineTracksSubject.next(updatedTracks);
        this.saveOfflineTracksToStorage(updatedTracks);

        return true;
      } else {
        // For non-M3U8 tracks, store the audio file directly
        const response = await fetch(track.audioUrl);
        const blob = await response.blob();
        const db = await this.getDB();

        // Store the audio blob
        await db.put('segments', { id: track.id, blob });

        // Create offline track data
        const offlineTrack: Track = {
          ...track,
          isOffline: true,
          offlineKey: track.id,
          dateAdded: Date.now()
        };

        // Add to offline tracks list
        const currentTracks = this.offlineTracksSubject.value;
        const updatedTracks = [...currentTracks, offlineTrack];
        this.offlineTracksSubject.next(updatedTracks);
        this.saveOfflineTracksToStorage(updatedTracks);

        return true;
      }
    } catch (error) {
      console.error('Error saving track for offline:', error);
      return false;
    }
  }

  async savePlaylistAndSegments(id: string, m3u8Url: string): Promise<void> {
    const db = await this.getDB();
    const baseUrl = m3u8Url.substring(0, m3u8Url.lastIndexOf('/') + 1);

    try {
      const m3u8Response = await fetch(m3u8Url);
      if (!m3u8Response.ok) {
        throw new Error(`Failed to fetch M3U8: ${m3u8Response.status}`);
      }

      const m3u8Content = await m3u8Response.text();
      await db.put('playlists', { id, content: m3u8Content });

      const { segmentItems, keyUri } = this.parseSegmentUrls(m3u8Content, baseUrl);

      // Download & store segments
      for (const segmentUrl of segmentItems) {
        try {
          const response = await fetch(segmentUrl.url);
          if (!response.ok) {
            console.error(`Failed to fetch segment: ${segmentUrl.url}`);
            continue;
          }
          const blob = await response.blob();
          await db.put('segments', { id: segmentUrl.url, blob });
        } catch (segError) {
          console.error(`Error downloading segment ${segmentUrl.url}:`, segError);
        }
      }

      // Download & store key if available
      if (keyUri) {
        try {
          const keyUrl = keyUri.startsWith('http') ? keyUri : baseUrl + keyUri;
          const keyResponse = await fetch(keyUrl);
          if (keyResponse.ok) {
            const keyBlob = await keyResponse.blob();
            await db.put('keys', { id: keyUrl, blob: keyBlob });
          } else {
            console.error(`Failed to fetch key: ${keyUrl}`);
          }
        } catch (keyError) {
          console.error('Error downloading key:', keyError);
        }
      }
    } catch (error) {
      console.error('Error saving playlist and segments:', error);
      throw error;
    }
  }

  async getOfflinePlaylist(id: string, m3u8Url: string): Promise<string> {
    const db = await this.getDB();
    const playlist = await db.get('playlists', id);

    if (!playlist) throw new Error('Playlist not found in storage.');

    let content = playlist.content;
    const baseUrl = m3u8Url.substring(0, m3u8Url.lastIndexOf('/') + 1);
    const { segmentItems, keyUri } = this.parseSegmentUrls(content, baseUrl);

    // Replace segment paths with blob URLs
    for (const item of segmentItems) {
      const segment = await db.get('segments', item.url);
      if (!segment) continue;
      const blobUrl = URL.createObjectURL(segment.blob);
      content = content.replace(item.name, blobUrl);
    }

    // Replace key URI with blob URL
    if (keyUri) {
      const keyUrl = keyUri.startsWith('http') ? keyUri : baseUrl + keyUri;
      const key = await db.get('keys', keyUrl);
      if (key) {
        const keyBlobUrl = URL.createObjectURL(key.blob);
        content = content.replace(keyUri, keyBlobUrl);
      }
    }

    const blob = new Blob([content], {
      type: 'application/vnd.apple.mpegurl'
    });
    return URL.createObjectURL(blob);
  }

  async getOfflineAudioUrl(track: Track): Promise<string> {
    if (!track.offlineKey) {
      throw new Error('Track has no offline key');
    }

    try {
      const db = await this.getDB();

      if (track.isM3u8) {
        return await this.getOfflinePlaylist(track.offlineKey, track.audioUrl);
      } else {
        // For regular audio files
        const segment = await db.get('segments', track.offlineKey);
        if (!segment) {
          throw new Error('Offline audio file not found');
        }
        return URL.createObjectURL(segment.blob);
      }
    } catch (error) {
      console.error('Error getting offline audio URL:', error);
      throw error;
    }
  }

  async removeTrackFromOffline(trackId: string): Promise<boolean> {
    try {
      const currentTracks = this.offlineTracksSubject.value;
      const trackToRemove = currentTracks.find((track) => track.id === trackId);

      if (!trackToRemove) {
        return false; // Track not found in offline list
      }

      const db = await this.getDB();

      // If it's an M3U8 track, cleanup related data
      if (trackToRemove.isM3u8) {
        try {
          // Delete playlist entry
          await db.delete('playlists', trackId);

          // Get content to find segments that need deletion
          const baseUrl = trackToRemove.audioUrl.substring(0, trackToRemove.audioUrl.lastIndexOf('/') + 1);
          const playlistContent = localStorage.getItem(`playlist_${trackId}`);

          if (playlistContent) {
            const { segmentItems, keyUri } = this.parseSegmentUrls(playlistContent, baseUrl);

            // Delete segments
            for (const segmentUrl of segmentItems) {
              try {
                await db.delete('segments', segmentUrl.url);
              } catch (segError) {
                console.error(`Error deleting segment ${segmentUrl.url}:`, segError);
              }
            }

            // Delete key if exists
            if (keyUri) {
              const keyUrl = keyUri.startsWith('http') ? keyUri : baseUrl + keyUri;
              try {
                await db.delete('keys', keyUrl);
              } catch (keyError) {
                console.error(`Error deleting key ${keyUrl}:`, keyError);
              }
            }

            // Remove from localStorage
            localStorage.removeItem(`playlist_${trackId}`);
          }
        } catch (cleanupError) {
          console.error('Error cleaning up M3U8 data:', cleanupError);
        }
      } else {
        // For regular audio, simply delete the segment
        await db.delete('segments', trackId);
      }

      // Update the tracks list
      const updatedTracks = currentTracks.filter((track) => track.id !== trackId);
      this.offlineTracksSubject.next(updatedTracks);
      this.saveOfflineTracksToStorage(updatedTracks);

      return true;
    } catch (error) {
      console.error('Error removing track from offline storage:', error);
      return false;
    }
  }
}
