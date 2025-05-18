import { Component, ElementRef, OnInit, ViewChild, OnDestroy } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { TableModule } from 'primeng/table';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { IconFieldModule } from 'primeng/iconfield';
import { PopoverModule } from 'primeng/popover';
import { ToastModule } from 'primeng/toast';
import { ProgressBarModule } from 'primeng/progressbar';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay, faPause, faPencil, faEllipsisH, faDownload } from '@fortawesome/free-solid-svg-icons';

import { UserService } from '../../../service/user.service';
import { TrackService } from '../../../service/track.service';
import { TrackDetailDto } from '../../../dto/track-dto';
import { MessageService } from 'primeng/api';
import { AudioService, EnhancedTrackDto } from '../../../service/audio.service';
import { Subscription } from 'rxjs';
import { take } from 'rxjs/operators';

@Component({
  selector: 'app-liked-songs',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    FormsModule,
    TableModule,
    ButtonModule,
    InputTextModule,
    IconFieldModule,
    PopoverModule,
    ToastModule,
    ProgressBarModule,
    FontAwesomeModule,
    DatePipe
  ],
  templateUrl: './liked-track.component.html',
  styleUrl: './liked-track.component.scss',
  providers: [MessageService]
})
export class LikedTrackComponent implements OnInit, OnDestroy {
  @ViewChild('playlistCover') playlistCoverImg: ElementRef | undefined;
  @ViewChild('trackOptionsPopover') trackOptionsPopover: any;

  // Font Awesome icons
  faPlay = faPlay;
  faPause = faPause;
  faPencil = faPencil;
  faEllipsisH = faEllipsisH;
  faDownload = faDownload;

  // Tracks data
  tracks: TrackDetailDto[] = [];
  enhancedTracks: EnhancedTrackDto[] = [];  // For audio service compatibility
  loading = true;
  isPlaying = false;
  backgroundColor = 'linear-gradient(to bottom, rgb(80, 56, 160), #121212)';
  selectedTrack: TrackDetailDto | null = null;
  ownerName: string = 'PHẠM TÙNG';
  
  // Current playing track reference
  currentTrack: EnhancedTrackDto | null = null;
  
  // Subscription management
  private subscriptions: Subscription[] = [];

  constructor(
    private userService: UserService,
    private trackService: TrackService,
    private messageService: MessageService,
    private audioService: AudioService
  ) {}

  ngOnInit(): void {
    this.loadLikedTracks();
    
    // Subscribe to audio service to track current playback state
    this.subscriptions.push(
      this.audioService.isPlaying$.subscribe((isPlaying) => {
        // Only update isPlaying state if one of our tracks is playing
        this.audioService.currentTrack$.pipe(take(1)).subscribe((currentTrack) => {
          if (currentTrack && this.tracks.some((track) => currentTrack.id === track.id)) {
            this.isPlaying = isPlaying;
          }
        });
      }),
      
      // Track the current track
      this.audioService.currentTrack$.subscribe(track => {
        this.currentTrack = track;
      })
    );
  }
  
  ngOnDestroy(): void {
    // Clean up all subscriptions when the component is destroyed
    this.subscriptions.forEach(sub => sub.unsubscribe());
  }

  loadLikedTracks(): void {
    this.loading = true;

    // Force a new API call to get fresh data from the server
    this.userService.getUserUsageData().subscribe(
      (response) => {
        if (response && response.data && response.data.likedTrackIds && response.data.likedTrackIds.length > 0) {
          // Get track details for all liked track IDs
          this.trackService.getTrackByIds(response.data.likedTrackIds).subscribe(
            (trackResponse) => {
              if (trackResponse && trackResponse.data) {
                this.tracks = trackResponse.data.filter((track) => track !== null);
                
                // Convert tracks to enhanced tracks for audio service
                this.enhancedTracks = this.tracks.map(track => ({
                  ...track,
                  isM3u8: !!track.audioFileM3u8Url,
                  dateAdded: Date.now()
                } as EnhancedTrackDto));
                
                this.loading = false;

                // Also get track stats to show additional information
                this.getTrackStats(response.data.likedTrackIds);
              } else {
                this.loading = false;
              }
            },
            (error) => {
              console.error('Error loading track details:', error);
              this.loading = false;
            }
          );
        } else {
          this.loading = false;
        }
      },
      (error) => {
        console.error('Error loading user data:', error);
        this.loading = false;
      }
    );
  }

  getTrackStats(trackIds: string[]): void {
    if (trackIds && trackIds.length > 0) {
      this.trackService.getTrackStatsByIds(trackIds).subscribe((response) => {
        if (response && response.data) {
          console.log('Track stats:', response.data);
          // We could use the stats data to show play count, etc.
          console.log('Track stats loaded');
        }
      });
    }
  }

  handlePlayPause(): void {
    if (this.tracks.length === 0) return;

    // Check if any track from the liked tracks is currently playing
    const isPlayingFromLikedTracks = this.isPlayingFromLikedTracks();

    if (isPlayingFromLikedTracks) {
      // Toggle play/pause state if already playing from liked tracks
      this.audioService.togglePlay();
    } else {
      // Otherwise, set the entire liked tracks as the queue and start playing
      this.audioService.setQueue(this.enhancedTracks);
      this.audioService.play();

      this.messageService.add({
        severity: 'success',
        summary: 'Now Playing',
        detail: 'Playing your Liked Songs'
      });
    }
  }

  private isPlayingFromLikedTracks(): boolean {
    // Check if the current track is from this liked tracks collection
    let isFromLikedTracks = false;

    this.audioService.currentTrack$.pipe(take(1)).subscribe((currentTrack) => {
      if (currentTrack) {
        isFromLikedTracks = this.tracks.some((track) => track.id === currentTrack.id);
      }
    });

    return isFromLikedTracks;
  }

  handleTrackPlay(track: TrackDetailDto): void {
    const enhancedTrack = this.enhancedTracks.find(t => t.id === track.id);
    if (!enhancedTrack) return;
    
    // Check if liked tracks are mostly in queue
    let tracksInQueue = 0;
    
    this.audioService.queue$.pipe(take(1)).subscribe((queue) => {
      const likedTrackIds = this.tracks.map((t) => t.id);
      tracksInQueue = queue.filter((queueTrack) => likedTrackIds.includes(queueTrack.id)).length;
    });
    
    const likedTracksInQueue = tracksInQueue >= this.tracks.length / 2;
    
    if (likedTracksInQueue) {
      // If many liked tracks are already in queue, just play this track
      this.audioService.setTrack(enhancedTrack);
      this.audioService.play();
    } else {
      // Otherwise, set all liked tracks as queue starting with the selected track
      const trackIndex = this.enhancedTracks.findIndex(t => t.id === track.id);
      if (trackIndex !== -1) {
        const reorderedTracks = [
          ...this.enhancedTracks.slice(trackIndex),
          ...this.enhancedTracks.slice(0, trackIndex)
        ];
        this.audioService.setQueue(reorderedTracks);
        this.audioService.play();
      }
    }
    
    this.messageService.add({
      severity: 'success',
      summary: 'Now Playing',
      detail: `Playing "${track.name}"`
    });
  }

  toggleTrackOptions(event: Event, track: TrackDetailDto): void {
    event.stopPropagation();
    this.selectedTrack = track;
    
    // Position the popover near the clicked element
    if (this.trackOptionsPopover) {
      this.trackOptionsPopover.toggle(event);
    }
  }
  addTrackToQueue(track: TrackDetailDto): void {
    const enhancedTrack = this.enhancedTracks.find(t => t.id === track.id);
    if (!enhancedTrack) return;
    
    if (this.audioService.addTrackDtoToQueue(enhancedTrack)) {
      this.messageService.add({
        severity: 'success',
        summary: 'Added to Queue',
        detail: `"${track.name}" has been added to your queue`
      });
    } else {
      this.messageService.add({
        severity: 'info',
        summary: 'Already in Queue',
        detail: `"${track.name}" is already in your queue`
      });
    }
  }
  
  addAllToQueue(): void {
    if (this.tracks.length === 0) return;

    // Add all liked tracks to the queue
    let addedCount = 0;

    // Try to add each track to the queue
    for (const track of this.enhancedTracks) {
      if (this.audioService.addTrackDtoToQueue(track)) {
        addedCount++;
      }
    }

    // Show success message
    if (addedCount > 0) {
      this.messageService.add({
        severity: 'success',
        summary: 'Added to Queue',
        detail: `${addedCount} track${addedCount !== 1 ? 's' : ''} from your Liked Songs added to queue`
      });
    } else {
      this.messageService.add({
        severity: 'info',
        summary: 'No Changes',
        detail: 'All tracks are already in your queue'
      });
    }
  }

  unlikeTrack(track: TrackDetailDto): void {
    if (track && track.id) {
      this.trackService.unlikeTrack(track.id);
      // Remove track from the local lists
      this.tracks = this.tracks.filter((t) => t.id !== track.id);
      this.enhancedTracks = this.enhancedTracks.filter((t) => t.id !== track.id);
      
      this.messageService.add({
        severity: 'success',
        summary: 'Removed',
        detail: `"${track.name}" removed from your Liked Songs`
      });
    }
  }

  formatTotalDuration(): string {
    const totalSeconds = this.tracks.reduce((sum, track) => {
      return sum + (track.audioDurationSecond || 0);
    }, 0);

    const hours = Math.floor(totalSeconds / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);

    if (hours > 0) {
      return `${hours} hr ${minutes} min`;
    } else {
      return `${minutes} min`;
    }
  }

  formatTrackDate(date: string | null): string {
    if (!date) return '';

    const today = new Date();
    const trackDate = new Date(date);
    const diffTime = Math.abs(today.getTime() - trackDate.getTime());
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    if (diffDays <= 1) return 'today';
    if (diffDays <= 2) return 'yesterday';
    if (diffDays <= 7) return `${diffDays} days ago`;

    return new Date(date).toLocaleDateString('en-US', {
      month: 'short',
      day: 'numeric',
      year: 'numeric'
    });
  }
}
