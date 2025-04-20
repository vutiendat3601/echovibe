import { Injectable, signal } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import Hls from 'hls.js';

export interface Track {
  id: string;
  name: string;
  artist: string;
  album?: string;
  duration: number;
  imageUrl?: string;
  audioUrl: string;
  isM3u8?: boolean;
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

  private currentTrackSubject = new BehaviorSubject<Track | null>(null);
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

  private playlistSubject = new BehaviorSubject<Track[]>([]);
  playlist$ = this.playlistSubject.asObservable();

  private shuffleSubject = new BehaviorSubject<boolean>(false);
  shuffle$ = this.shuffleSubject.asObservable();

  private repeatModeSubject = new BehaviorSubject<RepeatMode>(RepeatMode.OFF);
  repeatMode$ = this.repeatModeSubject.asObservable();

  private originalPlaylist: Track[] = [];
  private shuffledOrder: number[] = [];

  constructor() {
    this.initAudioEvents();

    const demoTrack: Track = {
      id: '1',
      name: 'Demo Track',
      artist: 'Demo Artist',
      album: 'Demo Album',
      duration: 180,
      imageUrl: 'assets/image/default-artist-thumbnail-image.png',
      audioUrl: 'https://raw.githubusercontent.com/vutiendat3601/cdn/_/aud/r001/3cc285667227ac0041e4eecae141c0c4/3cc285667227ac0041e4eecae141c0c4.m3u8',
      isM3u8: true
    };

    this.setPlaylist([demoTrack]);
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
        const playlist = this.playlistSubject.value;

        if (currentTrack) {
          const currentIndex = this.getCurrentTrackIndex();
          if (currentIndex < playlist.length - 1) {
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

    return this.playlistSubject.value.findIndex(t => t.id === currentTrack.id);
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
    this.originalPlaylist = [...this.playlistSubject.value];

    const indexes = Array.from({ length: this.originalPlaylist.length }, (_, i) => i);
    this.shuffledOrder = this.shuffleArray(indexes);

    if (this.currentTrackSubject.value) {
      const currentIndex = this.getCurrentTrackIndex();
      if (currentIndex !== -1) {
        this.shuffledOrder = this.shuffledOrder.filter(i => i !== currentIndex);
        this.shuffledOrder.unshift(currentIndex);
      }
    }

    this.applyShuffleOrder();
  }

  private disableShuffle(): void {
    if (this.originalPlaylist.length > 0) {
      const currentTrack = this.currentTrackSubject.value;

      this.playlistSubject.next([...this.originalPlaylist]);

      if (currentTrack) {
        const newIndex = this.playlistSubject.value.findIndex(t => t.id === currentTrack.id);
        if (newIndex !== -1) {
          this.currentTrackSubject.next(this.playlistSubject.value[newIndex]);
        }
      }
    }

    this.shuffledOrder = [];
    this.originalPlaylist = [];
  }

  private applyShuffleOrder(): void {
    const shuffledPlaylist = this.shuffledOrder.map(index => this.originalPlaylist[index]);
    this.playlistSubject.next(shuffledPlaylist);
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

  setTrack(track: Track): void {
    if (this.hls) {
      this.hls.destroy();
      this.hls = null;
    }

    this.audio.pause();
    this.audio.src = '';

    this.currentTrackSubject.next(track);

    if (track.isM3u8 && Hls.isSupported()) {
      this.hls = new Hls();
      this.hls.loadSource(track.audioUrl);
      this.hls.attachMedia(this.audio);
      this.hls.on(Hls.Events.MANIFEST_PARSED, () => {
      });

      this.hls.on(Hls.Events.ERROR, (event, data) => {
        console.error('HLS error:', data);
        if (data.fatal) {
          switch(data.type) {
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
      this.audio.src = track.audioUrl;
    }

    this.currentTimeSubject.next(0);
  }

  play(): void {
    const playPromise = this.audio.play();

    if (playPromise !== undefined) {
      playPromise.catch(error => {
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
      this.audio.muted = (volume === 0);
    }
  }

  setPlaylist(tracks: Track[]): void {
    this.playlistSubject.next(tracks);

    if (tracks.length > 0 && !this.currentTrackSubject.value) {
      this.setTrack(tracks[0]);
    }

    if (this.shuffleSubject.value && tracks.length > 0) {
      this.originalPlaylist = [...tracks];
      const indexes = Array.from({ length: tracks.length }, (_, i) => i);
      this.shuffledOrder = this.shuffleArray(indexes);
      this.applyShuffleOrder();
    }
  }

  addToPlaylist(track: Track): void {
    const currentPlaylist = this.playlistSubject.value;
    this.playlistSubject.next([...currentPlaylist, track]);

    if (currentPlaylist.length === 0) {
      this.setTrack(track);
    }

    if (this.shuffleSubject.value) {
      this.originalPlaylist.push(track);
      const newIndex = this.originalPlaylist.length - 1;

      const randomPosition = Math.floor(Math.random() * (this.shuffledOrder.length + 1));
      this.shuffledOrder.splice(randomPosition, 0, newIndex);

      this.applyShuffleOrder();
    }
  }

  next(): void {
    const currentTrack = this.currentTrackSubject.value;
    const playlist = this.playlistSubject.value;

    if (!currentTrack || playlist.length === 0) return;

    const currentIndex = playlist.findIndex(track => track.id === currentTrack.id);
    const nextIndex = (currentIndex + 1) % playlist.length;

    this.setTrack(playlist[nextIndex]);
    this.play();
  }

  previous(): void {
    const currentTrack = this.currentTrackSubject.value;
    const playlist = this.playlistSubject.value;

    if (!currentTrack || playlist.length === 0) return;

    const currentIndex = playlist.findIndex(track => track.id === currentTrack.id);

    if (this.currentTimeSubject.value <= 3) {
      const prevIndex = (currentIndex - 1 + playlist.length) % playlist.length;
      this.setTrack(playlist[prevIndex]);
    } else {
      this.setCurrentTime(0);
    }

    this.play();
  }

  removeFromPlaylist(trackId: string): void {
    const currentPlaylist = this.playlistSubject.value;
    const currentTrack = this.currentTrackSubject.value;

    const isRemovingCurrent = currentTrack && currentTrack.id === trackId;

    const trackIndex = currentPlaylist.findIndex(track => track.id === trackId);
    if (trackIndex === -1) return;

    const updatedPlaylist = currentPlaylist.filter(track => track.id !== trackId);

    if (this.shuffleSubject.value) {
      this.originalPlaylist = this.originalPlaylist.filter(track => track.id !== trackId);

      this.shuffledOrder = this.shuffledOrder
        .filter(i => i !== trackIndex)
        .map(i => i > trackIndex ? i - 1 : i);
    }

    this.playlistSubject.next(updatedPlaylist);

    if (isRemovingCurrent) {
      if (updatedPlaylist.length > 0) {
        const nextIndex = trackIndex < updatedPlaylist.length ? trackIndex : 0;
        this.setTrack(updatedPlaylist[nextIndex]);
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

    const track: Track = {
      id: Date.now().toString(),
      name: file.name.replace(/\.[^/.]+$/, ""),
      artist: 'Local File',
      duration: 0,
      audioUrl: fileUrl,
      isM3u8: isM3u8
    };

    this.addToPlaylist(track);
    this.setTrack(track);
    this.play();
  }

  loadM3u8Url(url: string, name: string = 'Stream'): void {
    if (!url) return;

    const track: Track = {
      id: Date.now().toString(),
      name: name,
      artist: 'Stream',
      duration: 0,
      audioUrl: url,
      isM3u8: true
    };

    this.addToPlaylist(track);
    this.setTrack(track);
    this.play();
  }
}
