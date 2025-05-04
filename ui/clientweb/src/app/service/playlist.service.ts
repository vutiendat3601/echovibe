import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, of } from 'rxjs';
import { PlaylistDto } from '../dto/playlist-dto';
import { TrackDto } from '../dto/track-dto';
import { ResponseDto } from '../dto/response-dto';
import { AudioService } from './audio.service';

@Injectable({
  providedIn: 'root'
})
export class PlaylistService {
  private readonly STORAGE_KEY = 'echovibe_playlists';

  // BehaviorSubject to track playlists and emit changes
  private playlistsSubject = new BehaviorSubject<PlaylistDto[]>(this.loadPlaylists());
  public playlists$ = this.playlistsSubject.asObservable();

  constructor(private audioService: AudioService) {}

  /**
   * Generate a simple ID for playlists (replacement for UUID)
   */
  private generateId(): string {
    return 'playlist_' + Date.now() + '_' + Math.random().toString(36).substring(2, 9);
  }

  /**
   * Create a new playlist
   */
  createPlaylist(name: string, description?: string, isPublic = true): Observable<ResponseDto<PlaylistDto>> {
    const newPlaylist: PlaylistDto = {
      id: this.generateId(),
      name,
      description,
      createdAt: Date.now(),
      updatedAt: Date.now(),
      creatorName: 'You', // In a real app, get from the authenticated user
      isPublic,
      tracks: []
    };

    const playlists = this.loadPlaylists();
    playlists.push(newPlaylist);
    this.savePlaylists(playlists);
    this.playlistsSubject.next(playlists);

    return of({
      data: newPlaylist,
      status: 'success',
      message: 'Playlist created successfully',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Get all playlists
   */
  getPlaylists(): Observable<ResponseDto<PlaylistDto[]>> {
    const playlists = this.loadPlaylists();
    return of({
      data: playlists,
      status: 'success',
      message: 'Playlists retrieved successfully',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Get a specific playlist by ID
   */
  getPlaylistById(id: string): Observable<ResponseDto<PlaylistDto | null>> {
    const playlists = this.loadPlaylists();
    const playlist = playlists.find(p => p.id === id) || null;

    return of({
      data: playlist,
      status: playlist ? 'success' : 'error',
      message: playlist ? 'Playlist retrieved successfully' : 'Playlist not found',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Update a playlist's details
   */
  updatePlaylist(
    id: string,
    name?: string,
    description?: string,
    coverImageUrl?: string,
    isPublic?: boolean
  ): Observable<ResponseDto<PlaylistDto | null>> {
    const playlists = this.loadPlaylists();
    const playlistIndex = playlists.findIndex(p => p.id === id);

    if (playlistIndex === -1) {
      return of({
        data: null,
        status: 'error',
        message: 'Playlist not found',
        timestamp: new Date().toISOString()
      });
    }

    const updatedPlaylist = {
      ...playlists[playlistIndex],
      name: name !== undefined ? name : playlists[playlistIndex].name,
      description: description !== undefined ? description : playlists[playlistIndex].description,
      coverImageUrl: coverImageUrl !== undefined ? coverImageUrl : playlists[playlistIndex].coverImageUrl,
      isPublic: isPublic !== undefined ? isPublic : playlists[playlistIndex].isPublic,
      updatedAt: Date.now()
    };

    playlists[playlistIndex] = updatedPlaylist;
    this.savePlaylists(playlists);
    this.playlistsSubject.next(playlists);

    return of({
      data: updatedPlaylist,
      status: 'success',
      message: 'Playlist updated successfully',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Delete a playlist
   */
  deletePlaylist(id: string): Observable<ResponseDto<boolean>> {
    const playlists = this.loadPlaylists();
    const filteredPlaylists = playlists.filter(p => p.id !== id);

    if (filteredPlaylists.length === playlists.length) {
      return of({
        data: false,
        status: 'error',
        message: 'Playlist not found',
        timestamp: new Date().toISOString()
      });
    }

    this.savePlaylists(filteredPlaylists);
    this.playlistsSubject.next(filteredPlaylists);

    return of({
      data: true,
      status: 'success',
      message: 'Playlist deleted successfully',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Add a track to a playlist
   */
  addTrackToPlaylist(playlistId: string, track: TrackDto): Observable<ResponseDto<PlaylistDto | null>> {
    const playlists = this.loadPlaylists();
    const playlistIndex = playlists.findIndex(p => p.id === playlistId);

    if (playlistIndex === -1) {
      return of({
        data: null,
        status: 'error',
        message: 'Playlist not found',
        timestamp: new Date().toISOString()
      });
    }

    // Check if track already exists in the playlist
    const trackExists = playlists[playlistIndex].tracks.some(t => t.id === track.id);

    if (trackExists) {
      return of({
        data: playlists[playlistIndex],
        status: 'error',
        message: 'Track already exists in playlist',
        timestamp: new Date().toISOString()
      });
    }

    // Add track and update timestamps
    playlists[playlistIndex].tracks.push(track);
    playlists[playlistIndex].updatedAt = Date.now();

    // If this is the first track, use its cover image for the playlist
    if (playlists[playlistIndex].tracks.length === 1 && track.thumbnailUrl && !playlists[playlistIndex].coverImageUrl) {
      playlists[playlistIndex].coverImageUrl = track.thumbnailUrl;
    }

    this.savePlaylists(playlists);
    this.playlistsSubject.next(playlists);

    return of({
      data: playlists[playlistIndex],
      status: 'success',
      message: 'Track added to playlist successfully',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Remove a track from a playlist
   */
  removeTrackFromPlaylist(playlistId: string, trackId: string): Observable<ResponseDto<PlaylistDto | null>> {
    const playlists = this.loadPlaylists();
    const playlistIndex = playlists.findIndex(p => p.id === playlistId);

    if (playlistIndex === -1) {
      return of({
        data: null,
        status: 'error',
        message: 'Playlist not found',
        timestamp: new Date().toISOString()
      });
    }

    const trackIndex = playlists[playlistIndex].tracks.findIndex(t => t.id === trackId);

    if (trackIndex === -1) {
      return of({
        data: playlists[playlistIndex],
        status: 'error',
        message: 'Track not found in playlist',
        timestamp: new Date().toISOString()
      });
    }

    // Remove track and update timestamps
    playlists[playlistIndex].tracks.splice(trackIndex, 1);
    playlists[playlistIndex].updatedAt = Date.now();

    // Update cover image if no tracks left
    if (playlists[playlistIndex].tracks.length === 0) {
      playlists[playlistIndex].coverImageUrl = undefined;
    } else if (trackIndex === 0 && playlists[playlistIndex].tracks.length > 0) {
      // If the first track was removed, use the new first track's cover
      const thumbnailUrl = playlists[playlistIndex].tracks[0].thumbnailUrl;
      playlists[playlistIndex].coverImageUrl = thumbnailUrl || undefined;
    }

    this.savePlaylists(playlists);
    this.playlistsSubject.next(playlists);

    return of({
      data: playlists[playlistIndex],
      status: 'success',
      message: 'Track removed from playlist successfully',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Play a track from a playlist
   */
  playTrackFromPlaylist(playlistId: string, trackId: string): Observable<ResponseDto<boolean>> {
    const playlists = this.loadPlaylists();
    const playlist = playlists.find(p => p.id === playlistId);

    if (!playlist) {
      return of({
        data: false,
        status: 'error',
        message: 'Playlist not found',
        timestamp: new Date().toISOString()
      });
    }

    const track = playlist.tracks.find(t => t.id === trackId);

    if (!track) {
      return of({
        data: false,
        status: 'error',
        message: 'Track not found in playlist',
        timestamp: new Date().toISOString()
      });
    }

    this.audioService.setTrackFromDto(track);
    this.audioService.play();

    return of({
      data: true,
      status: 'success',
      message: 'Playing track from playlist',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Play all tracks in a playlist
   */
  playPlaylist(playlistId: string): Observable<ResponseDto<boolean>> {
    const playlists = this.loadPlaylists();
    const playlist = playlists.find(p => p.id === playlistId);

    if (!playlist) {
      return of({
        data: false,
        status: 'error',
        message: 'Playlist not found',
        timestamp: new Date().toISOString()
      });
    }

    if (playlist.tracks.length === 0) {
      return of({
        data: false,
        status: 'error',
        message: 'Playlist is empty',
        timestamp: new Date().toISOString()
      });
    }

    // Clear the queue and add all tracks from the playlist
    this.audioService.clearQueue();

    // Add all tracks to queue
    playlist.tracks.forEach(track => {
      this.audioService.addTrackDtoToQueue(track);
    });

    // Start playing the first track
    this.audioService.setTrackFromDto(playlist.tracks[0]);
    this.audioService.play();

    return of({
      data: true,
      status: 'success',
      message: 'Playing playlist',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Add all tracks from a playlist to the current queue
   */
  addPlaylistToQueue(playlistId: string): Observable<ResponseDto<boolean>> {
    const playlists = this.loadPlaylists();
    const playlist = playlists.find(p => p.id === playlistId);

    if (!playlist) {
      return of({
        data: false,
        status: 'error',
        message: 'Playlist not found',
        timestamp: new Date().toISOString()
      });
    }

    if (playlist.tracks.length === 0) {
      return of({
        data: false,
        status: 'error',
        message: 'Playlist is empty',
        timestamp: new Date().toISOString()
      });
    }

    // Add all tracks to queue
    playlist.tracks.forEach(track => {
      this.audioService.addTrackDtoToQueue(track);
    });

    return of({
      data: true,
      status: 'success',
      message: 'Added playlist to queue',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Reorder tracks within a playlist
   */
  reorderTracks(playlistId: string, fromIndex: number, toIndex: number): Observable<ResponseDto<PlaylistDto | null>> {
    const playlists = this.loadPlaylists();
    const playlistIndex = playlists.findIndex(p => p.id === playlistId);

    if (playlistIndex === -1) {
      return of({
        data: null,
        status: 'error',
        message: 'Playlist not found',
        timestamp: new Date().toISOString()
      });
    }

    const playlist = playlists[playlistIndex];

    if (fromIndex < 0 || fromIndex >= playlist.tracks.length ||
        toIndex < 0 || toIndex >= playlist.tracks.length) {
      return of({
        data: playlist,
        status: 'error',
        message: 'Invalid track indices',
        timestamp: new Date().toISOString()
      });
    }

    // Perform the reordering
    const [movedTrack] = playlist.tracks.splice(fromIndex, 1);
    playlist.tracks.splice(toIndex, 0, movedTrack);
    playlist.updatedAt = Date.now();

    this.savePlaylists(playlists);
    this.playlistsSubject.next(playlists);

    return of({
      data: playlist,
      status: 'success',
      message: 'Tracks reordered successfully',
      timestamp: new Date().toISOString()
    });
  }

  /**
   * Get all local storage saved playlists
   */
  private loadPlaylists(): PlaylistDto[] {
    try {
      const storedPlaylists = localStorage.getItem(this.STORAGE_KEY);
      return storedPlaylists ? JSON.parse(storedPlaylists) : [];
    } catch (error) {
      console.error('Error loading playlists from localStorage:', error);
      return [];
    }
  }

  /**
   * Save playlists to local storage
   */
  private savePlaylists(playlists: PlaylistDto[]): void {
    try {
      localStorage.setItem(this.STORAGE_KEY, JSON.stringify(playlists));
    } catch (error) {
      console.error('Error saving playlists to localStorage:', error);
    }
  }
}
