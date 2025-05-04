import { Component, OnInit, ElementRef, ViewChild, Renderer2 } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { TrackDto } from '../../../dto/track-dto';
import { TrackService } from '../../../service/track.service';
import { AudioService } from '../../../service/audio.service';
import { ProgressBarModule } from 'primeng/progressbar';
import { BadgeModule } from 'primeng/badge';
import { CardModule } from 'primeng/card';
import { ButtonModule } from 'primeng/button';
import { OverlayPanelModule } from 'primeng/overlaypanel';
import { ToastModule } from 'primeng/toast';
import { MessageService } from 'primeng/api';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay, faPause, faHeart, faEllipsisH, faPlus } from '@fortawesome/free-solid-svg-icons';
import { environment } from '../../../../environment/environment';
import ColorThief from 'colorthief';
import { Subscription } from 'rxjs';
import { Popover } from 'primeng/popover';
import { PopoverModule } from 'primeng/popover';
import { ActivityService } from '../../../service/activity.service';
import { ActionType } from '../../../constant/action-type';

@Component({
  selector: 'app-track-detail',
  templateUrl: './track-detail.component.html',
  styleUrls: ['./track-detail.component.scss'],
  standalone: true,
  imports: [
    CommonModule,
    ProgressBarModule,
    BadgeModule,
    CardModule,
    ButtonModule,
    OverlayPanelModule,
    FontAwesomeModule,
    RouterLink,
    ToastModule,
    PopoverModule
  ],
  providers: [MessageService, ActivityService]
})
export class TrackDetailComponent implements OnInit {
  @ViewChild('trackThumbnail') trackThumbnail!: ElementRef;
  @ViewChild('op') op!: Popover;

  track: TrackDto | null = null;
  isLoading = true;
  errorMessage = '';
  backgroundColor = 'rgba(18, 18, 18, 1)';

  // Track playback state
  isPlaying = false;
  isCurrentTrack = false;
  private subscriptions: Subscription[] = [];

  // Icons
  faPlay = faPlay;
  faPause = faPause;
  faHeart = faHeart;
  faEllipsisH = faEllipsisH;
  faPlus = faPlus;

  // Feature flags
  useMockData = !environment.production; // Use mock data in non-production environments

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private trackService: TrackService,
    private audioService: AudioService,
    private renderer: Renderer2,
    private messageService: MessageService,
    private acitivityService: ActivityService
  ) {}

  ngOnInit(): void {
    const trackId = this.route.snapshot.paramMap.get('id');
    if (trackId) {
      this.loadTrackDetails(trackId);
    } else {
      this.router.navigate(['/not-found']);
    }

    // Subscribe to audio service to track current playback state
    this.subscriptions.push(
      this.audioService.currentTrack$.subscribe((currentTrack) => {
        if (this.track && currentTrack) {
          this.isCurrentTrack = currentTrack.id === this.track.id;
        } else {
          this.isCurrentTrack = false;
        }
      }),

      this.audioService.isPlaying$.subscribe((isPlaying) => {
        this.isPlaying = isPlaying && this.isCurrentTrack;
      })
    );
  }

  toggle(event: Event): void {
    this.op.toggle(event);
  }

  // Play or pause the current track
  handlePlayClick(): void {
    if (!this.track || !this.track.audioFileM3u8Url) return;

    if (this.isCurrentTrack) {
      // If this is already the current track, just toggle play/pause
      this.audioService.togglePlay();
    } else {
      // If this is a new track, set it and play
      this.audioService.setTrackFromDto(this.track);
      this.audioService.play();
    }
  }

  // Add current track to queue
  addToQueue(): void {
    if (!this.track) return;

    // Check if the track already exists in the queue
    if (this.audioService.isTrackInQueue(this.track.id)) {
      this.messageService.add({
        severity: 'info',
        summary: 'Already in Queue',
        detail: `"${this.track.name}" is already in your play queue`
      });
      return;
    }

    // Add track to queue
    this.audioService.addTrackDtoToQueue(this.track);
    this.messageService.add({
      severity: 'success',
      summary: 'Added to Queue',
      detail: `"${this.track.name}" has been added to your queue`
    });
  }

  private loadTrackDetails(trackId: string): void {
    this.isLoading = true;
    this.trackService.getTrackById(trackId).subscribe({
      next: (response) => {
        this.track = response.data;
        this.isLoading = false;
        if (!this.track) {
          this.errorMessage = 'Track not found';
        } else {
          this.acitivityService.send({
            sessionId: null,
            aggregateId: this.track.id,
            type: ActionType.VIEW_TRACK_DETAIL_PAGE,
            dataJson: null
            // {
            // name: 'Những bài hát hay nhất của Sơn Tùng M-TP',
            // isPublic: true,
            // thumbnailUrl: null,
            // trackIds: ['wtzugknWgsmi', 'pdzsaqauHvgD']
            // }
          });
          // Extract color after image is loaded
          setTimeout(() => this.extractColorFromThumbnail(), 300);
        }
      },
      error: (error) => {
        this.errorMessage = 'Failed to load track details';
        this.isLoading = false;
        console.error('Error loading track details', error);
      }
    });
  }

  extractColorFromThumbnail(): void {
    if (!this.trackThumbnail?.nativeElement) return;

    const img = this.trackThumbnail.nativeElement;

    // Make sure image is fully loaded
    if (img.complete) {
      this.getColorAndApply(img);
    } else {
      img.onload = () => {
        this.getColorAndApply(img);
      };

      // Add error handling for the image
      img.onerror = () => {
        console.warn('Image failed to load properly for color extraction');
        this.useDefaultBackground();
      };
    }
  }

  private getColorAndApply(img: HTMLImageElement): void {
    try {
      const colorThief = new ColorThief();
      const color = colorThief.getColor(img);

      if (color && color.length === 3) {
        // Create gradient with dominant color
        const [r, g, b] = color;
        this.backgroundColor = `linear-gradient(to bottom, rgba(${r}, ${g}, ${b}, 0.8) 0%, rgba(18, 18, 18, 1) 90%)`;
      } else {
        this.useDefaultBackground();
      }
    } catch (error) {
      console.error('Error extracting color:', error);
      // If we get a CORS error, try the fallback
      this.useDefaultBackground();
    }
  }

  private useDefaultBackground(): void {
    // Use fallback color if extraction fails
    this.backgroundColor = 'linear-gradient(to bottom, rgba(60, 60, 60, 0.8), rgba(18, 18, 18, 1))';
  }

  formatDuration(seconds: number): string {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
  }

  formatPlayCount(count: number): string {
    if (count >= 1000000) {
      return `${(count / 1000000).toFixed(1)}M`;
    } else if (count >= 1000) {
      return `${(count / 1000).toFixed(1)}K`;
    }
    return count.toString();
  }

  ngOnDestroy(): void {
    // Clean up subscriptions
    this.subscriptions.forEach((sub) => sub.unsubscribe());
  }
}
