import { TrackStatsDto, TrackDetailDto } from './../../../dto/track-dto';
import { AuthService } from './../../../service/auth.service';
import { UserService } from './../../../service/user.service';
import { CommonModule } from '@angular/common';
import { Component, ElementRef, OnInit, Renderer2, ViewChild } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faEllipsisH, faHeart, faPause, faPlay, faPlus } from '@fortawesome/free-solid-svg-icons';
import ColorThief from 'colorthief';
import { MessageService } from 'primeng/api';
import { BadgeModule } from 'primeng/badge';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { OverlayPanelModule } from 'primeng/overlaypanel';
import { Popover, PopoverModule } from 'primeng/popover';
import { ProgressBarModule } from 'primeng/progressbar';
import { ToastModule } from 'primeng/toast';
import { Subscription } from 'rxjs';
import { environment } from '../../../../environment/environment';
import { ActivityService } from '../../../service/activity.service';
import { AudioService } from '../../../service/audio.service';
import { TrackService } from './../../../service/track.service';
import { TrackingService } from '../../../service/tracking.service';
import { MessageResponseDto } from '../../../dto/activity-dto';

interface TrackStats {
  totalDetailPageViews: number;
  totalLikes: number;
  totalListens: number;
}

interface ArtistDetailOfTrack {
  id: string;
  urn: string;
  name: string;
  description: string | null;
  thumbnailUrl: string | null;
  isPublic: boolean;
  isVerified: boolean;
  isMainArtist: boolean;
}

interface TrackDetail {
  id: string;
  urn: string;
  name: string;
  description: string | null;
  thumbnailUrl: string | null;
  officialReleasedDate: string | null;
  isPublic: boolean;
  audioFileM3u8Url: string | null;
  audioDurationSecond: number;
  tags: string[];
  artists: ArtistDetailOfTrack[];
  stats: TrackStats;
}

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
  private viewTrackingDetailTrackingSessionId: string | null = null;
  private readonly intervalIds: number[] = [];
  @ViewChild('trackThumbnail') trackThumbnail!: ElementRef;
  @ViewChild('op') op!: Popover;

  trackDetail: TrackDetail | null = null;
  isLiked: boolean = false;
  isLoading = true;
  errorMessage = '';
  backgroundColor = 'rgba(18, 18, 18, 1)';
  isAuthenticated: boolean = false;

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
    private readonly route: ActivatedRoute,
    private readonly router: Router,
    private readonly trackService: TrackService,
    private readonly audioService: AudioService,
    private readonly renderer: Renderer2,
    private readonly messageService: MessageService,
    private readonly userService: UserService,
    private readonly authService: AuthService,
    private readonly trackingService: TrackingService
  ) {}

  ngOnInit(): void {
    this.initialize();
    const trackId = this.route.snapshot.paramMap.get('id');
    if (trackId) {
      this.loadData(trackId);
      this.listenDataChange();
      this.listenTrackingEvent();
      this.userService.refresh();
    } else {
      this.router.navigate(['/not-found']);
    }

    // Subscribe to audio service to track current playback state
    this.subscriptions.push(
      this.audioService.currentTrack$.subscribe((currentTrack) => {
        if (this.trackDetail && currentTrack) {
          this.isCurrentTrack = currentTrack.id === this.trackDetail.id;
        } else {
          this.isCurrentTrack = false;
        }
      }),

      this.audioService.isPlaying$.subscribe((isPlaying) => {
        this.isPlaying = isPlaying && this.isCurrentTrack;
      })
    );
  }

  initialize() {
    this.isAuthenticated = this.authService.isAuthenticated;
  }

  toggle(event: Event): void {
    this.op.toggle(event);
  }

  // Play or pause the current track
  handlePlayClick(): void {
    if (!this.trackDetail || !this.trackDetail.audioFileM3u8Url) return;

    if (this.isCurrentTrack) {
      // If this is already the current track, just toggle play/pause
      this.audioService.togglePlay();
    } else {
      // If this is a new track, set it and play
      this.audioService.setTrackFromDto(this.trackDetail);
      this.audioService.play();
    }
  }

  handleLikeState() {
    if (this.trackDetail) {
      if (this.isLiked) {
        this.trackService.unlikeTrack(this.trackDetail.id);
      } else {
        this.trackService.likeTrack(this.trackDetail.id);
      }
    }
  }

  // Add current track to queue
  addToQueue(): void {
    if (!this.trackDetail) return;

    // Check if the track already exists in the queue
    if (this.audioService.isTrackInQueue(this.trackDetail.id)) {
      this.messageService.add({
        severity: 'info',
        summary: 'Already in Queue',
        detail: `"${this.trackDetail.name}" is already in your play queue`
      });
      return;
    }

    // Add track to queue
    this.audioService.addTrackDtoToQueue(this.trackDetail);
    this.messageService.add({
      severity: 'success',
      summary: 'Added to Queue',
      detail: `"${this.trackDetail.name}" has been added to your queue`
    });
  }

  private loadData(trackId: string): void {
    this.isLoading = true;
    this.trackService.getTrackById(trackId).subscribe({
      next: (response) => {
        const trackDetailDto = response.data;
        if (trackDetailDto) {
          const trackDetail = this.mapToTrackDetail(trackDetailDto);
          this.isLoading = false;
          this.trackService.getTrackStats(trackDetail.id).subscribe((respDto) => {
            const { totalDetailPageViews, totalLikes, totalListens } = respDto.data;
            trackDetail.stats = { totalDetailPageViews, totalLikes, totalListens };
          });
          this.trackDetail = trackDetail;
          console.log(this.trackDetail);
          this.initializeTracking();
          window.setTimeout(() => this.extractColorFromThumbnail(), 300);
        } else {
          this.errorMessage = 'Track not found';
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

  private initializeTracking() {
    if (this.trackDetail) {
      this.trackingService.startViewTrackDetailPageTracking(this.trackDetail.id);
    }
  }

  private listenDataChange() {
    this.userService.userUsageData.subscribe(({ likedTrackIds }) => {
      this.trackDetail && (this.isLiked = likedTrackIds.includes(this.trackDetail.id));
    });
  }

  private listenTrackingEvent() {
    this.trackingService.viewTrackDetailPageTracking.subscribe(({ sessionId, aggregateId }: MessageResponseDto) => {
      if (this.trackDetail && aggregateId === this.trackDetail.id && sessionId) {
        this.viewTrackingDetailTrackingSessionId = sessionId;
        window.setTimeout(() => {
          this.trackingService.sendViewedTrackDetailPageTracking(sessionId);
        }, 10_000);
      }
    });
  }

  private mapToTrackDetail(trackDetailDto: TrackDetailDto): TrackDetail {
    const {
      id,
      urn,
      name,
      description,
      thumbnailUrl,
      officialReleasedDate,
      isPublic,
      audioFileM3u8Url,
      audioDurationSecond,
      tags,
      artists
    } = trackDetailDto;
    return {
      id,
      urn,
      name,
      description,
      thumbnailUrl,
      officialReleasedDate,
      isPublic,
      audioFileM3u8Url,
      audioDurationSecond,
      tags,
      artists,
      stats: {
        totalDetailPageViews: 0,
        totalLikes: 0,
        totalListens: 0
      }
    };
  }

  ngOnDestroy(): void {
    this.viewTrackingDetailTrackingSessionId &&
      this.trackingService.sendViewedTrackDetailPageTracking(this.viewTrackingDetailTrackingSessionId);

    // Clean up subscriptions
    this.subscriptions.forEach((sub) => sub.unsubscribe());
  }
}
