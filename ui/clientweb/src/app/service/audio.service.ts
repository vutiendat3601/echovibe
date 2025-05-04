import { Injectable, signal, inject } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import Hls from 'hls.js';
import { OfflineAudioService } from './offline-audio.service';
import { TrackDto } from '../dto/track-dto';

// Additional fields needed for tracks in the audio service
export interface EnhancedTrackDto extends TrackDto {
  isM3u8?: boolean;
  isOffline?: boolean;
  offlineKey?: string;
  dateAdded?: number; // timestamp for when the track was added offline
  // Optional fields to support legacy behaviors
  album?: string;
}

export enum RepeatMode {
  OFF = 'off',
  ALL = 'all',
  ONE = 'one'
}

@Injectable({
  providedIn: 'root'
})
export class AudioService {
  private audio = new Audio();
  private hls: Hls | null = null;

  private currentTrackSubject = new BehaviorSubject<EnhancedTrackDto | null>(null);
  currentTrack$ = this.currentTrackSubject.asObservable();

  private isPlayingSubject = new BehaviorSubject<boolean>(false);
  isPlaying$ = this.isPlayingSubject.asObservable();

  private currentTimeSubject = new BehaviorSubject<number>(0);
  currentTime$ = this.currentTimeSubject.asObservable();

  private durationSubject = new BehaviorSubject<number>(0);
  duration$ = this.durationSubject.asObservable();

  private volumeSubject = new BehaviorSubject<number>(75);
  volume$ = this.volumeSubject.asObservable();

  private muteSubject = new BehaviorSubject<boolean>(false);
  mute$ = this.muteSubject.asObservable();

  // Renamed from playlistSubject to queueSubject
  private queueSubject = new BehaviorSubject<EnhancedTrackDto[]>([]);
  queue$ = this.queueSubject.asObservable(); // Renamed from playlist$ to queue$

  private shuffleSubject = new BehaviorSubject<boolean>(false);
  shuffle$ = this.shuffleSubject.asObservable();

  private repeatModeSubject = new BehaviorSubject<RepeatMode>(RepeatMode.OFF);
  repeatMode$ = this.repeatModeSubject.asObservable();

  // Forward the offline tracks observable from OfflineAudioService
  get offlineTracks$() {
    return this.offlineAudioService.offlineTracks$;
  }

  private originalQueue: EnhancedTrackDto[] = []; // Renamed from originalPlaylist
  private shuffledOrder: number[] = [];

  constructor(private offlineAudioService: OfflineAudioService) {
    this.initAudioEvents();
  }

  // Helper method to get the main artist name or combined artist names
  getArtistName(track: EnhancedTrackDto): string {
    if (!track.artists || track.artists.length === 0) return 'Unknown Artist';

    const mainArtist = track.artists.find(artist => artist.isMainArtist);
    if (mainArtist) {
      return mainArtist.name;
    }
    return track.artists.map(artist => artist.name).join(', ');
  }

  private initAudioEvents(): void {
    this.audio.addEventListener('timeupdate', () => {
      this.currentTimeSubject.next(this.audio.currentTime);
    });

    this.audio.addEventListener('durationchange', () => {
      this.durationSubject.next(this.audio.duration);
    });

    this.audio.addEventListener('ended', () => {
      const repeatMode = this.repeatModeSubject.value;

      if (repeatMode === RepeatMode.ONE) {
        this.audio.currentTime = 0;
        this.play();
      } else if (repeatMode === RepeatMode.ALL || this.shuffleSubject.value) {
        this.next();
      } else {
        const currentTrack = this.currentTrackSubject.value;
        const queue = this.queueSubject.value;

        if (currentTrack) {
          const currentIndex = this.getCurrentTrackIndex();
          if (currentIndex < queue.length - 1) {
            this.next();
          } else {
            this.isPlayingSubject.next(false);
          }
        }
      }
    });

    this.audio.addEventListener('play', () => {
      this.isPlayingSubject.next(true);
    });

    this.audio.addEventListener('pause', () => {
      this.isPlayingSubject.next(false);
    });

    this.audio.volume = this.volumeSubject.value / 100;
  }

  private getCurrentTrackIndex(): number {
    const currentTrack = this.currentTrackSubject.value;
    if (!currentTrack) return -1;

    return this.queueSubject.value.findIndex((t) => t.id === currentTrack.id);
  }

  toggleShuffle(): void {
    const newShuffleState = !this.shuffleSubject.value;
    this.shuffleSubject.next(newShuffleState);

    if (newShuffleState) {
      this.enableShuffle();
    } else {
      this.disableShuffle();
    }
  }

  private enableShuffle(): void {
    this.originalQueue = [...this.queueSubject.value];

    const indexes = Array.from({ length: this.originalQueue.length }, (_, i) => i);
    this.shuffledOrder = this.shuffleArray(indexes);

    if (this.currentTrackSubject.value) {
      const currentIndex = this.getCurrentTrackIndex();
      if (currentIndex !== -1) {
        this.shuffledOrder = this.shuffledOrder.filter((i) => i !== currentIndex);
        this.shuffledOrder.unshift(currentIndex);
      }
    }

    this.applyShuffleOrder();
  }

  private disableShuffle(): void {
    if (this.originalQueue.length > 0) {
      const currentTrack = this.currentTrackSubject.value;

      this.queueSubject.next([...this.originalQueue]);

      if (currentTrack) {
        const newIndex = this.queueSubject.value.findIndex((t) => t.id === currentTrack.id);
        if (newIndex !== -1) {
          this.currentTrackSubject.next(this.queueSubject.value[newIndex]);
        }
      }
    }

    this.shuffledOrder = [];
    this.originalQueue = [];
  }

  private applyShuffleOrder(): void {
    const shuffledQueue = this.shuffledOrder.map((index) => this.originalQueue[index]);
    this.queueSubject.next(shuffledQueue);
  }

  private shuffleArray<T>(array: T[]): T[] {
    const result = [...array];
    for (let i = result.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [result[i], result[j]] = [result[j], result[i]];
    }
    return result;
  }

  toggleRepeat(): void {
    const currentMode = this.repeatModeSubject.value;
    let nextMode: RepeatMode;

    switch (currentMode) {
      case RepeatMode.OFF:
        nextMode = RepeatMode.ALL;
        break;
      case RepeatMode.ALL:
        nextMode = RepeatMode.ONE;
        break;
      case RepeatMode.ONE:
        nextMode = RepeatMode.OFF;
        break;
      default:
        nextMode = RepeatMode.OFF;
    }

    this.repeatModeSubject.next(nextMode);
  }

  toggleMute(): void {
    const newMuteState = !this.muteSubject.value;
    this.muteSubject.next(newMuteState);
    this.audio.muted = newMuteState;
  }

  setTrack(track: EnhancedTrackDto): void {
    if (this.hls) {
      this.hls.destroy();
      this.hls = null;
    }

    this.audio.pause();
    this.audio.src = '';

    this.currentTrackSubject.next(track);

    // Use audioFileM3u8Url for M3U8 tracks
    const audioUrl = track.audioFileM3u8Url || track.isM3u8 ? track.audioFileM3u8Url : '';
    if (!audioUrl) {
      console.error('Track has no audio URL');
      return;
    }

    if ((track.isM3u8 || track.audioFileM3u8Url) && Hls.isSupported()) {
      this.hls = new Hls();
      this.hls.loadSource(audioUrl);
      this.hls.attachMedia(this.audio);
      this.hls.on(Hls.Events.MANIFEST_PARSED, () => {});

      this.hls.on(Hls.Events.ERROR, (event, data) => {
        console.error('HLS error:', data);
        if (data.fatal) {
          switch (data.type) {
            case Hls.ErrorTypes.NETWORK_ERROR:
              console.error('HLS network error');
              this.hls?.startLoad();
              break;
            case Hls.ErrorTypes.MEDIA_ERROR:
              console.error('HLS media error');
              this.hls?.recoverMediaError();
              break;
            default:
              console.error('Unrecoverable HLS error');
              this.hls?.destroy();
              break;
          }
        }
      });
    } else {
      this.audio.src = audioUrl;
    }

    this.currentTimeSubject.next(0);
  }

  // Method to play a track from TrackDto (automatically converts to EnhancedTrackDto)
  setTrackFromDto(trackDto: TrackDto): void {
    // Convert the basic TrackDto to EnhancedTrackDto
    const enhancedTrack: EnhancedTrackDto = {
      ...trackDto,
      isM3u8: !!trackDto.audioFileM3u8Url // Set isM3u8 based on whether audioFileM3u8Url exists
    };

    // Use the existing setTrack method with the enhanced track
    this.setTrack(enhancedTrack);
    // Add the track to the queue if it's not already there
    if (!this.isTrackInQueue(enhancedTrack.id)) {
      this.addToQueue(enhancedTrack);
    }
  }

  // Method to add a TrackDto to the queue (renamed from addTrackDtoToPlaylist)
  addTrackDtoToQueue(trackDto: TrackDto): boolean {
    // First check if the track is already in the queue
    if (this.isTrackInQueue(trackDto.id)) {
      return false; // Track already exists in queue
    }

    // Convert the basic TrackDto to EnhancedTrackDto
    const enhancedTrack: EnhancedTrackDto = {
      ...trackDto,
      isM3u8: !!trackDto.audioFileM3u8Url // Set isM3u8 based on whether audioFileM3u8Url exists
    };

    // Use the existing addToQueue method with the enhanced track
    this.addToQueue(enhancedTrack);
    return true; // Successfully added track to queue
  }

  play(): void {
    const playPromise = this.audio.play();

    if (playPromise !== undefined) {
      playPromise.catch((error) => {
        console.error('Playback failed:', error);
      });
    }
  }

  pause(): void {
    this.audio.pause();
  }

  togglePlay(): void {
    if (this.isPlayingSubject.value) {
      this.pause();
    } else {
      this.play();
    }
  }

  setCurrentTime(time: number): void {
    if (time >= 0 && time <= this.audio.duration) {
      this.audio.currentTime = time;
    }
  }

  setVolume(volume: number): void {
    if (volume >= 0 && volume <= 100) {
      this.volumeSubject.next(volume);
      this.audio.volume = volume / 100;
      this.muteSubject.next(volume === 0);
      this.audio.muted = volume === 0;
    }
  }

  // Renamed from setPlaylist to setQueue
  setQueue(tracks: EnhancedTrackDto[]): void {
    this.queueSubject.next(tracks);

    if (tracks.length > 0 && !this.currentTrackSubject.value) {
      this.setTrack(tracks[0]);
    }

    if (this.shuffleSubject.value && tracks.length > 0) {
      this.originalQueue = [...tracks];
      const indexes = Array.from({ length: tracks.length }, (_, i) => i);
      this.shuffledOrder = this.shuffleArray(indexes);
      this.applyShuffleOrder();
    }
  }

  // Renamed from addToPlaylist to addToQueue
  addToQueue(track: EnhancedTrackDto): void {
    const currentQueue = this.queueSubject.value;
    this.queueSubject.next([...currentQueue, track]);

    if (currentQueue.length === 0) {
      this.setTrack(track);
    }

    if (this.shuffleSubject.value) {
      this.originalQueue.push(track);
      const newIndex = this.originalQueue.length - 1;

      const randomPosition = Math.floor(Math.random() * (this.shuffledOrder.length + 1));
      this.shuffledOrder.splice(randomPosition, 0, newIndex);

      this.applyShuffleOrder();
    }
  }

  next(): void {
    const currentTrack = this.currentTrackSubject.value;
    const queue = this.queueSubject.value;

    if (!currentTrack || queue.length === 0) return;

    const currentIndex = queue.findIndex((track) => track.id === currentTrack.id);
    const nextIndex = (currentIndex + 1) % queue.length;

    this.setTrack(queue[nextIndex]);
    this.play();
  }

  previous(): void {
    const currentTrack = this.currentTrackSubject.value;
    const queue = this.queueSubject.value;

    if (!currentTrack || queue.length === 0) return;

    const currentIndex = queue.findIndex((track) => track.id === currentTrack.id);

    if (this.currentTimeSubject.value <= 3) {
      const prevIndex = (currentIndex - 1 + queue.length) % queue.length;
      this.setTrack(queue[prevIndex]);
    } else {
      this.setCurrentTime(0);
    }

    this.play();
  }

  // Renamed from removeFromPlaylist to removeFromQueue
  removeFromQueue(trackId: string): void {
    const currentQueue = this.queueSubject.value;
    const currentTrack = this.currentTrackSubject.value;

    const isRemovingCurrent = currentTrack && currentTrack.id === trackId;

    const trackIndex = currentQueue.findIndex((track) => track.id === trackId);
    if (trackIndex === -1) return;

    const updatedQueue = currentQueue.filter((track) => track.id !== trackId);

    if (this.shuffleSubject.value) {
      this.originalQueue = this.originalQueue.filter((track) => track.id !== trackId);

      this.shuffledOrder = this.shuffledOrder.filter((i) => i !== trackIndex).map((i) => (i > trackIndex ? i - 1 : i));
    }

    this.queueSubject.next(updatedQueue);

    if (isRemovingCurrent) {
      if (updatedQueue.length > 0) {
        const nextIndex = trackIndex < updatedQueue.length ? trackIndex : 0;
        this.setTrack(updatedQueue[nextIndex]);
        this.play();
      } else {
        this.audio.pause();
        this.audio.src = '';
        this.currentTrackSubject.next(null);
        this.isPlayingSubject.next(false);
      }
    }
  }

  formatTime(seconds: number): string {
    const minutes: number = Math.floor(seconds / 60);
    const remainingSeconds: number = Math.floor(seconds % 60);
    return `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
  }

  loadAudioFile(file: File): void {
    const isM3u8 = file.name.endsWith('.m3u8');
    const fileUrl = URL.createObjectURL(file);

    const track: EnhancedTrackDto = {
      id: Date.now().toString(),
      urn: `local:track:${Date.now()}`,
      name: file.name.replace(/\.[^/.]+$/, ''),
      description: 'Local audio file',
      thumbnailUrl: null,
      officialReleasedDate: null,
      isPublic: false,
      audioFileM3u8Url: isM3u8 ? fileUrl : null,
      audioDurationSecond: 0,
      tags: ['local'],
      artists: [ {
        id: '0',
        urn: 'local:artist:0',
        name: 'Local File',
        description: null,
        thumbnailUrl: null,
        isPublic: false,
        isVerified: false,
        isMainArtist: true
      }],
      isM3u8: isM3u8
    };

    this.addToQueue(track);
    this.setTrack(track);
    this.play();
  }

  loadM3u8Url(url: string, name: string = 'Stream'): void {
    if (!url) return;

    const track: EnhancedTrackDto = {
      id: Date.now().toString(),
      urn: `stream:track:${Date.now()}`,
      name: name,
      description: 'Streaming audio',
      thumbnailUrl: null,
      officialReleasedDate: null,
      isPublic: false,
      audioFileM3u8Url: url,
      audioDurationSecond: 0,
      tags: ['stream'],
      artists: [ {
        id: '0',
        urn: 'stream:artist:0',
        name: 'Stream',
        description: null,
        thumbnailUrl: null,
        isPublic: false,
        isVerified: false,
        isMainArtist: true
      }],
      isM3u8: true
    };

    this.addToQueue(track);
    this.setTrack(track);
    this.play();
  }

  // Offline methods delegated to OfflineAudioService
  isTrackSavedOffline(trackId: string): boolean {
    return this.offlineAudioService.isTrackSavedOffline(trackId);
  }

  async saveTrackForOffline(track: EnhancedTrackDto): Promise<boolean> {
    return this.offlineAudioService.saveTrackForOffline(track);
  }

  async removeTrackFromOffline(trackId: string): Promise<boolean> {
    return this.offlineAudioService.removeTrackFromOffline(trackId);
  }

  // New method to play offline tracks
  async playOfflineTrack(track: EnhancedTrackDto): Promise<void> {
    try {
      if (!track.offlineKey) {
        throw new Error('Track has no offline key');
      }

      // Get offline audio URL
      const offlineUrl = await this.offlineAudioService.getOfflineAudioUrl(track);

      // Create a new track instance with the offline URL
      const offlineTrack: EnhancedTrackDto = {
        ...track,
        audioFileM3u8Url: offlineUrl
      };

      // Set and play the track
      this.setTrack(offlineTrack);
      this.play();
    } catch (error) {
      console.error('Error playing offline track:', error);
      throw error;
    }
  }

  // Renamed from isTrackInPlaylist to isTrackInQueue
  isTrackInQueue(trackId: string): boolean {
    return this.queueSubject.value.some(track => track.id === trackId);
  }

  // Method to clear the queue
  clearQueue(): void {
    this.queueSubject.next([]);
    this.originalQueue = [];
    this.shuffledOrder = [];
  }
}
