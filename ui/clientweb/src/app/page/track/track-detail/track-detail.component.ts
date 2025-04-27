import { Component, OnInit, ElementRef, ViewChild, Renderer2 } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { TrackDto } from '../../../dto/track-dto';
import { TrackService } from '../../../service/track.service';
import { ProgressBarModule } from 'primeng/progressbar';
import { BadgeModule } from 'primeng/badge';
import { CardModule } from 'primeng/card';
import { ButtonModule } from 'primeng/button';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay, faHeart, faEllipsisH } from '@fortawesome/free-solid-svg-icons';
import { environment } from '../../../../environment/environment';
import ColorThief from 'colorthief';

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
    FontAwesomeModule,
    RouterLink
  ]
})
export class TrackDetailComponent implements OnInit {
  @ViewChild('trackThumbnail') trackThumbnail!: ElementRef;

  track: TrackDto | null = null;
  isLoading = true;
  errorMessage = '';
  backgroundColor = 'rgba(18, 18, 18, 1)';

  // Icons
  faPlay = faPlay;
  faHeart = faHeart;
  faEllipsisH = faEllipsisH;

  // Feature flags
  useMockData = !environment.production; // Use mock data in non-production environments

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private trackService: TrackService,
    private renderer: Renderer2
  ) {}

  ngOnInit(): void {
    const trackId = this.route.snapshot.paramMap.get('id');
    if (trackId) {
      this.loadTrackDetails(trackId);
    } else {
      this.router.navigate(['/not-found']);
    }
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
}
