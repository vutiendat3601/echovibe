import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AudioService, EnhancedTrackDto, RepeatMode } from '../../../service/audio.service';
import { OfflineAudioService } from '../../../service/offline-audio.service';
import { Router, RouterLink } from '@angular/router';
import { Subscription } from 'rxjs';
import { MessageService } from 'primeng/api';
import { Toast } from 'primeng/toast';
import { faBackwardStep, faForwardStep, faPause, faPlay, faShuffle } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

@Component({
  selector: 'app-now-playing-bar',
  standalone: true,
  imports: [CommonModule, FormsModule, Toast, FontAwesomeModule, RouterLink],
  templateUrl: './now-playing-bar.component.html',
  styleUrl: './now-playing-bar.component.scss',
  providers: [MessageService]
})
export class NowPlayingBarComponent implements OnInit, OnDestroy {
  currentTrack: EnhancedTrackDto | null = null;
  isPlaying: boolean = false;
  currentTime: number = 0;
  duration: number = 0;
  volumePercent: number = 100;
  progressPercent: number = 0;

  // Icons
  faShuffle = faShuffle;
  faPlay = faPlay;
  faPause = faPause;
  faForwardStep = faForwardStep;
  faBackwardStep = faBackwardStep;

  // New properties for extended functionality
  isMuted: boolean = false;
  isShuffled: boolean = false;
  repeatMode: RepeatMode = RepeatMode.OFF;
  showQueue: boolean = false;
  queue: EnhancedTrackDto[] = []; // Renamed from playlist

  // Offline properties
  offlineTracks: EnhancedTrackDto[] = [];

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

      this.audioService.queue$.subscribe((queue) => { // Renamed from playlist$ to queue$
        this.queue = queue;
      }),

      this.offlineAudioService.offlineTracks$.subscribe((tracks) => {
        this.offlineTracks = tracks;
      })
    );
  }

  // Get artist name from EnhancedTrackDto
  getArtistName(track: EnhancedTrackDto | null): string {
    if (!track) return '';

    if (!track.artists || track.artists.length === 0) return 'Unknown Artist';

    const mainArtist = track.artists.find(artist => artist.isMainArtist);
    if (mainArtist) {
      return mainArtist.name;
    }
    return track.artists.map(artist => artist.name).join(', ');
  }

  // Get thumbnail image URL
  getImageUrl(track: EnhancedTrackDto | null): string {
    if (!track) return 'assets/image/default-artist-thumbnail-image.png';

    return track.thumbnailUrl || 'assets/image/default-artist-thumbnail-image.png';
  }

  // Playback controls
  handleTogglePlay(): void {
    this.audioService.togglePlay();
  }

  handleNext(): void {
    this.audioService.next();
  }

  handlePrevious(): void {
    this.audioService.previous();
  }

  // New control methods
  handleToggleShuffle(): void {
    this.audioService.toggleShuffle();
  }

  handleToggleRepeat(): void {
    this.audioService.toggleRepeat();
  }

  handleToggleMute(): void {
    this.audioService.toggleMute();
  }

  handleToggleQueue(): void {
    this.showQueue = !this.showQueue;
  }

  // Track selection from queue
  handlePlayTrack(track: EnhancedTrackDto): void {
    this.audioService.setTrack(track);
    this.audioService.play();
  }

  // Remove track from queue
  handleRemoveTrack(event: Event, trackId: string): void {
    event.stopPropagation();
    this.audioService.removeFromQueue(trackId); // Renamed from removeFromPlaylist
  }

  // Get the next up tracks (all tracks except the current one)
  handleGetNextUpTracks(): EnhancedTrackDto[] {
    if (!this.currentTrack || this.queue.length <= 1) {
      return [];
    }

    return this.queue.filter((track) => track.id !== this.currentTrack?.id);
  }

  // Clear the entire queue
  handleClearQueue(): void {
    if (confirm('Are you sure you want to clear the entire queue?')) {
      // Reset audio but keep the current track
      const currentTrack = this.currentTrack;
      this.audioService.setQueue(currentTrack ? [currentTrack] : []);
    }
  }

  // Offline methods
  handleIsTrackSavedOffline(trackId: string | undefined): boolean {
    if (!trackId) return false;
    return this.offlineAudioService.isTrackSavedOffline(trackId);
  }

  async handleToggleOfflineSave(track: EnhancedTrackDto | null): Promise<void> {
    if (!track) return;

    try {
      if (this.handleIsTrackSavedOffline(track.id)) {
        // Remove from offline
        const success = await this.offlineAudioService.removeTrackFromOffline(track.id);
        if (success) {
          this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Song removed from offline library' });
        } else {
          this.messageService.add({ severity: 'error', summary: 'Error', detail: 'Failed to remove song from offline library' });
        }
      } else {
        // Add to offline
        const success = await this.audioService.saveTrackForOffline(track);
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

  // Handle repeat icon based on repeat mode
  handleGetRepeatIcon(): string {
    switch (this.repeatMode) {
      case RepeatMode.ALL:
        return 'pi-sync';
      case RepeatMode.ONE:
        return 'pi-sync pi-sync-one';
      default:
        return 'pi-sync';
    }
  }

  // Format time in seconds to MM:SS format
  handleFormatTime(seconds: number): string {
    if (!seconds || isNaN(seconds)) return '0:00';

    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = Math.floor(seconds % 60);
    return `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
  }

  // Set playback position when clicking on the progress bar
  handleSetPosition(event: MouseEvent): void {
    const progressBar = event.currentTarget as HTMLElement;
    const clickPosition = event.offsetX / progressBar.offsetWidth;
    const seekTime = this.duration * clickPosition;
    this.audioService.setCurrentTime(seekTime);
  }

  // Get appropriate volume icon based on volume level and mute state
  handleGetVolumeIcon(): string {
    if (this.isMuted || this.volumePercent === 0) {
      return 'pi-volume-off';
    } else if (this.volumePercent < 50) {
      return 'pi-volume-down';
    } else {
      return 'pi-volume-up';
    }
  }

  // Set volume when clicking on the volume bar
  handleSetVolume(event: MouseEvent): void {
    const volumeBar = event.currentTarget as HTMLElement;
    const rect = volumeBar.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const clickPositionPercent = (x / rect.width) * 100;

    // Ensure volume is within valid range (0-100)
    const newVolume = Math.max(0, Math.min(100, clickPositionPercent));
    this.audioService.setVolume(newVolume);
  }

  ngOnDestroy(): void {
    // Unsubscribe from all subscriptions
    this.subscriptions.forEach((sub) => sub.unsubscribe());
  }
}
