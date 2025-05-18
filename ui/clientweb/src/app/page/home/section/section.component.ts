import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { UserService } from '../../../service/user.service';
import { TrackService } from '../../../service/track.service';
import { PlaylistService } from '../../../service/playlist.service';
import { AudioService, EnhancedTrackDto } from '../../../service/audio.service';
import { Subscription } from 'rxjs';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay, faPause } from '@fortawesome/free-solid-svg-icons';
import { ButtonModule } from 'primeng/button';
import { PlaylistDetailDto } from '../../../dto/playlist-dto';
import { TrackDetailDto } from '../../../dto/track-dto';
import { MessageService } from 'primeng/api';
import { ToastModule } from 'primeng/toast';

@Component({
  selector: 'app-section',
  standalone: true,
  imports: [CommonModule, RouterModule, FontAwesomeModule, ButtonModule, ToastModule],
  templateUrl: './section.component.html',
  styleUrl: './section.component.scss',
  providers: [MessageService]
})
export class SectionComponent implements OnInit, OnDestroy {
  // Icons
  faPlay = faPlay;
  faPause = faPause;

  // Section type
  sectionType: string = 'popular';

  // Data
  items: any[] = [];

  // Current track for play/pause indication
  currentTrack: EnhancedTrackDto | null = null;
  isPlaying: boolean = false;

  // Loading state
  isLoading: boolean = true;

  // Subscription management
  private subscriptions: Subscription[] = [];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private userService: UserService,
    private trackService: TrackService,
    private playlistService: PlaylistService,
    private audioService: AudioService,
    private messageService: MessageService
  ) {}

  ngOnInit(): void {
    // Get section type from route
    this.route.params.subscribe((params) => {
      if (params['type']) {
        this.sectionType = params['type'];
        this.loadData();
      } else {
        this.router.navigate(['/not-found']);
      }
    });

    // Subscribe to audio service to track current playing state
    this.subscriptions.push(
      this.audioService.currentTrack$.subscribe((track) => {
        this.currentTrack = track;
      }),

      this.audioService.isPlaying$.subscribe((playing) => {
        this.isPlaying = playing;
      })
    );
  }

  ngOnDestroy(): void {
    // Clean up subscriptions
    this.subscriptions.forEach((sub) => sub.unsubscribe());
  }

  loadData(): void {
    this.isLoading = true;

    if (this.sectionType === 'popular') {
      this.loadPopularTracks();
    } else if (this.sectionType === 'recommended') {
      this.loadRecommendedTracks();
    } else if (this.sectionType === 'playlists') {
      this.loadUserPlaylists();
    }
  }

  loadPopularTracks(): void {
    this.userService.getUserRecommendation().subscribe(
      (response) => {
        if (response && response.data && response.data.mostPopularTrackIdsCurrentMonth) {
          // Get track details for popular tracks
          this.trackService.getTrackByIds(response.data.mostPopularTrackIdsCurrentMonth).subscribe(
            (tracksResponse) => {
              let tracks: TrackDetailDto[] = [];
              if (Array.isArray(tracksResponse.data)) {
                tracks = tracksResponse.data.filter((track): track is TrackDetailDto => track !== null);
              }
              // Convert to enhanced tracks for audio service
              this.items = tracks.map((track) => ({
                ...track,
                isM3u8: !!track.audioFileM3u8Url
              }));
              this.isLoading = false;
            },
            (error) => {
              console.error('Error loading popular tracks:', error);
              this.isLoading = false;
            }
          );
        } else {
          this.isLoading = false;
        }
      },
      (error) => {
        console.error('Error loading popular tracks data:', error);
        this.isLoading = false;
      }
    );
  }

  loadRecommendedTracks(): void {
    this.userService.getUserRecommendation().subscribe(
      (response) => {
        if (response && response.data && response.data.recommendedTrackIds) {
          // Get track details for recommended tracks
          this.trackService.getTrackByIds(response.data.recommendedTrackIds).subscribe(
            (tracksResponse) => {
              let tracks: TrackDetailDto[] = [];
              if (Array.isArray(tracksResponse.data)) {
                tracks = tracksResponse.data.filter((track): track is TrackDetailDto => track !== null);
              }
              // Convert to enhanced tracks for audio service
              this.items = tracks.map((track) => ({
                ...track,
                isM3u8: !!track.audioFileM3u8Url
              }));
              this.isLoading = false;
            },
            (error) => {
              console.error('Error loading recommended tracks:', error);
              this.isLoading = false;
            }
          );
        } else {
          this.isLoading = false;
        }
      },
      (error) => {
        console.error('Error loading user recommendations:', error);
        this.isLoading = false;
      }
    );
  }

  loadUserPlaylists(): void {
    // Subscribe to userUsageData observable to get continuously updated data
    this.subscriptions.push(
      this.userService.userUsageData.subscribe((userData) => {
        if (userData && userData.createdPlaylistIds && userData.createdPlaylistIds.length > 0) {
          // Get playlist details for user's playlists
          this.playlistService.getPlaylistByIds(userData.createdPlaylistIds).subscribe(
            (playlistsResponse) => {
              if (playlistsResponse && playlistsResponse.data) {
                this.items = playlistsResponse.data;
              }
              this.isLoading = false;
            },
            (error) => {
              console.error('Error loading user playlists:', error);
              this.isLoading = false;
            }
          );
        } else {
          this.isLoading = false;
        }
      })
    );

    // Trigger a refresh of user data
    this.userService.refresh();
  }

  // Get the appropriate thumbnail image for a playlist
  getPlaylistThumbnail(playlist: PlaylistDetailDto): string {
    // If playlist has its own thumbnail, use it
    if (playlist.thumbnailUrl) {
      return playlist.thumbnailUrl;
    }

    // If playlist has tracks, use the first track's thumbnail
    if (playlist.tracks && playlist.tracks.length > 0 && playlist.tracks[0].thumbnailUrl) {
      return playlist.tracks[0].thumbnailUrl;
    }

    // Otherwise, return empty string - the component will show the default icon
    return '';
  }

  // Play a track
  playTrack(track: EnhancedTrackDto, event: Event): void {
    event.stopPropagation();

    if (this.currentTrack && this.currentTrack.id === track.id) {
      // Toggle play/pause if it's the current track
      this.audioService.togglePlay();
    } else {
      // Play a new track
      this.audioService.setTrackFromDto(track);
      this.audioService.play();

      this.messageService.add({
        severity: 'success',
        summary: 'Now Playing',
        detail: `Playing "${track.name}"`
      });
    }
  }

  // Navigate to track detail page
  goToTrack(track: EnhancedTrackDto): void {
    this.router.navigate(['/track', track.id]);
  }

  // Navigate to playlist page
  goToPlaylist(playlist: PlaylistDetailDto): void {
    this.router.navigate(['/playlist', playlist.id]);
  }

  // Get primary artist name for a track
  getArtistName(track: EnhancedTrackDto): string {
    if (!track.artists || track.artists.length === 0) {
      return 'Unknown Artist';
    }

    // Find main artist first
    const mainArtist = track.artists.find((artist) => artist.isMainArtist);
    if (mainArtist) {
      return mainArtist.name;
    }

    // If no main artist specified, use first artist
    return track.artists[0].name;
  }

  // Check if a specific track is currently playing
  isTrackPlaying(track: EnhancedTrackDto): boolean {
    return this.isPlaying && this.currentTrack !== null && this.currentTrack.id === track.id;
  }

  // Truncate text if it exceeds the maximum length
  truncateText(text: string, maxLength: number = 25): string {
    if (!text) return '';
    return text.length > maxLength ? text.substring(0, maxLength) + '...' : text;
  }

  getSectionTitle(): string {
    switch (this.sectionType) {
      case 'popular':
        return 'Popular albums and singles';
      case 'recommended':
        return 'Recommended for you';
      case 'playlists':
        return 'Your Playlists';
      default:
        return 'Music';
    }
  }
}
