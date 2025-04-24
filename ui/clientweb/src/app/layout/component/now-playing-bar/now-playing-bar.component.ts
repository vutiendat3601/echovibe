import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AudioService, Track, RepeatMode } from '../../../service/audio.service';
import { OfflineAudioService } from '../../../service/offline-audio.service';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { MessageService } from 'primeng/api';
import { Toast } from 'primeng/toast';

@Component({
  selector: 'app-now-playing-bar',
  standalone: true,
  imports: [CommonModule, FormsModule, Toast],
  templateUrl: './now-playing-bar.component.html',
  styleUrl: './now-playing-bar.component.scss',
  providers: [MessageService]
})
export class NowPlayingBarComponent implements OnInit, OnDestroy {
  currentTrack: Track | null = null;
  isPlaying: boolean = false;
  currentTime: number = 0;
  duration: number = 0;
  volumePercent: number = 100;
  progressPercent: number = 0;

  // New properties for extended functionality
  isMuted: boolean = false;
  isShuffled: boolean = false;
  repeatMode: RepeatMode = RepeatMode.OFF;
  showQueue: boolean = false;
  playlist: Track[] = [];

  // Offline properties
  offlineTracks: Track[] = [];

  private subscriptions: Subscription[] = [];

  constructor(
    private audioService: AudioService,
    private offlineAudioService: OfflineAudioService,
    private router: Router,
    private messageService: MessageService
  ) {}

  ngOnInit(): void {
    // Subscribe to audio service observables
    this.subscriptions.push(
      this.audioService.currentTrack$.subscribe((track) => {
        this.currentTrack = track;
      }),

      this.audioService.isPlaying$.subscribe((isPlaying) => {
        this.isPlaying = isPlaying;
      }),

      this.audioService.currentTime$.subscribe((time) => {
        this.currentTime = time;
        if (this.duration > 0) {
          this.progressPercent = (this.currentTime / this.duration) * 100;
        }
      }),

      this.audioService.duration$.subscribe((duration) => {
        this.duration = duration;
      }),

      this.audioService.volume$.subscribe((volume) => {
        this.volumePercent = volume;
      }),

      this.audioService.mute$.subscribe((muted) => {
        this.isMuted = muted;
      }),

      this.audioService.shuffle$.subscribe((shuffled) => {
        this.isShuffled = shuffled;
      }),

      this.audioService.repeatMode$.subscribe((mode) => {
        this.repeatMode = mode;
      }),

      this.audioService.playlist$.subscribe((playlist) => {
        this.playlist = playlist;
      }),

      this.offlineAudioService.offlineTracks$.subscribe((tracks) => {
        this.offlineTracks = tracks;
      })
    );
  }

  // Playback controls
  togglePlay(): void {
    this.audioService.togglePlay();
  }

  next(): void {
    this.audioService.next();
  }

  previous(): void {
    this.audioService.previous();
  }

  // New control methods
  toggleShuffle(): void {
    this.audioService.toggleShuffle();
  }

  toggleRepeat(): void {
    this.audioService.toggleRepeat();
  }

  toggleMute(): void {
    this.audioService.toggleMute();
  }

  toggleQueue(): void {
    this.showQueue = !this.showQueue;
  }

  // Track selection from queue
  playTrack(track: Track): void {
    this.audioService.setTrack(track);
    this.audioService.play();
  }

  // Remove track from queue
  removeTrack(event: Event, trackId: string): void {
    event.stopPropagation();
    this.audioService.removeFromPlaylist(trackId);
  }

  // Position and volume controls
  setPosition(event: MouseEvent): void {
    const progressBar = event.currentTarget as HTMLElement;
    const clickPosition = event.offsetX / progressBar.offsetWidth;
    const seekTime = this.duration * clickPosition;
    this.audioService.setCurrentTime(seekTime);
  }

  setVolume(event: MouseEvent): void {
    const volumeBar = event.currentTarget as HTMLElement;
    const clickPosition = event.offsetX / volumeBar.offsetWidth;
    const volume = Math.round(clickPosition * 100);
    this.audioService.setVolume(volume);
  }

  formatTime(seconds: number): string {
    return this.audioService.formatTime(seconds);
  }

  // Helper methods for template
  getRepeatIcon(): string {
    switch (this.repeatMode) {
      case RepeatMode.ONE:
        return 'pi-sync pi-sync-one';
      case RepeatMode.ALL:
        return 'pi-sync';
      default:
        return 'pi-sync pi-sync-off';
    }
  }

  getVolumeIcon(): string {
    if (this.isMuted || this.volumePercent === 0) {
      return 'pi-volume-off';
    } else if (this.volumePercent < 50) {
      return 'pi-volume-down';
    } else {
      return 'pi-volume-up';
    }
  }

  isCurrentTrack(track: Track): boolean {
    return !!this.currentTrack && this.currentTrack.id === track.id;
  }

  // Get the next up tracks (all tracks except the current one)
  getNextUpTracks(): Track[] {
    if (!this.currentTrack || this.playlist.length <= 1) {
      return [];
    }

    return this.playlist.filter((track) => track.id !== this.currentTrack?.id);
  }

  // Clear the entire queue
  clearQueue(): void {
    if (confirm('Are you sure you want to clear the entire queue?')) {
      // Reset audio but keep the current track
      const currentTrack = this.currentTrack;
      this.audioService.setPlaylist(currentTrack ? [currentTrack] : []);
    }
  }

  // Offline methods
  isTrackSavedOffline(trackId: string | undefined): boolean {
    if (!trackId) return false;
    return this.offlineAudioService.isTrackSavedOffline(trackId);
  }

  async toggleOfflineSave(track: Track | null): Promise<void> {
    if (!track) return;

    try {
      if (this.isTrackSavedOffline(track.id)) {
        // Remove from offline
        const success = await this.offlineAudioService.removeTrackFromOffline(track.id);
        if (success) {
          this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Song removed from offline library' });
        } else {
          this.messageService.add({ severity: 'error', summary: 'Error', detail: 'Failed to remove song from offline library' });
        }
      } else {
        // Add to offline
        const success = await this.offlineAudioService.saveTrackForOffline(track);
        if (success) {
          this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Song saved for offline listening' });
        } else {
          this.messageService.add({ severity: 'error', summary: 'Error', detail: 'Failed to save song for offline listening' });
        }
      }
    } catch (error) {
      this.messageService.add({ severity: 'error', summary: 'Error', detail: 'Error saving song for offline listening' });
    }
  }

  ngOnDestroy(): void {
    // Unsubscribe from all subscriptions
    this.subscriptions.forEach((sub) => sub.unsubscribe());
  }
}
