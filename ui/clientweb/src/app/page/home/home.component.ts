import { Component, OnDestroy, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { UserService } from '../../service/user.service';
import { TrackService } from '../../service/track.service';
import { PlaylistService } from '../../service/playlist.service';
import { AudioService } from '../../service/audio.service';
import { AuthService } from '../../service/auth.service';
import { Subscription } from 'rxjs';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay, faPause } from '@fortawesome/free-solid-svg-icons';
import { ButtonModule } from 'primeng/button';
import { EnhancedTrackDto } from '../../service/audio.service';
import { PlaylistDetailDto } from '../../dto/playlist-dto';
import { TrackDetailDto } from '../../dto/track-dto';
import { MessageService } from 'primeng/api';
import { ToastModule } from 'primeng/toast';
import { CarouselModule } from 'primeng/carousel';
import { UserProfile } from '../../model/user-profile';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, RouterModule, FontAwesomeModule, ButtonModule, ToastModule, CarouselModule],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss',
  providers: [MessageService]
})
export class HomeComponent implements OnInit, OnDestroy {
  // Icons
  faPlay = faPlay;
  faPause = faPause;

  // Active filter tab
  activeFilter: string = 'all';

  // Data for sections
  recommendedTracks: EnhancedTrackDto[] = [];
  popularTracks: EnhancedTrackDto[] = [];
  userPlaylists: PlaylistDetailDto[] = [];

  // User profile data
  userProfile: UserProfile = {};
  userName: string = 'User';

  // Current track for play/pause indication
  currentTrack: EnhancedTrackDto | null = null;
  isPlaying: boolean = false;
  // Loading states
  isLoadingRecommendations: boolean = true;
  isLoadingPopular: boolean = true;
  isLoadingPlaylists: boolean = true;

  // Subscription management
  private subscriptions: Subscription[] = [];

  // Carousel configuration
  responsiveOptions = [
    {
      breakpoint: '1600px',
      numVisible: 5,
      numScroll: 1
    },
    {
      breakpoint: '1200px',
      numVisible: 4,
      numScroll: 1
    },
    {
      breakpoint: '900px',
      numVisible: 3,
      numScroll: 1
    },
    {
      breakpoint: '700px',
      numVisible: 2,
      numScroll: 1
    },
    {
      breakpoint: '500px',
      numVisible: 1,
      numScroll: 1
    }
  ];

  constructor(
    private userService: UserService,
    private trackService: TrackService,
    private playlistService: PlaylistService,
    private audioService: AudioService,
    private authService: AuthService,
    private router: Router,
    private messageService: MessageService
  ) {}

  ngOnInit(): void {
    // Get user recommendations (personalized tracks)
    this.loadRecommendedTracks();

    // Get popular tracks
    this.loadPopularTracks();

    // Get user playlists
    this.loadUserPlaylists();

    // Subscribe to user profile for username
    this.subscriptions.push(
      this.authService.userProfile().subscribe((profile) => {
        this.userProfile = profile;
        // Set username from profile, with fallbacks
        if (profile.info?.name) {
          this.userName = profile.info.name;
        } else if (profile.info?.preferred_username) {
          this.userName = profile.info.preferred_username;
        } else if (profile.info?.given_name && profile.info?.family_name) {
          this.userName = `${profile.info.given_name} ${profile.info.family_name}`;
        }
      })
    );

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

  loadRecommendedTracks(): void {
    this.isLoadingRecommendations = true;

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
              this.recommendedTracks = tracks.map((track) => ({
                ...track,
                isM3u8: !!track.audioFileM3u8Url
              }));
              this.isLoadingRecommendations = false;
            },
            (error) => {
              console.error('Error loading recommended tracks:', error);
              this.isLoadingRecommendations = false;
            }
          );
        } else {
          this.isLoadingRecommendations = false;
        }
      },
      (error) => {
        console.error('Error loading user recommendations:', error);
        this.isLoadingRecommendations = false;
      }
    );
  }

  loadPopularTracks(): void {
    this.isLoadingPopular = true;

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
              this.popularTracks = tracks.map((track) => ({
                ...track,
                isM3u8: !!track.audioFileM3u8Url
              }));
              this.isLoadingPopular = false;
            },
            (error) => {
              console.error('Error loading popular tracks:', error);
              this.isLoadingPopular = false;
            }
          );
        } else {
          this.isLoadingPopular = false;
        }
      },
      (error) => {
        console.error('Error loading popular tracks data:', error);
        this.isLoadingPopular = false;
      }
    );
  }
  loadUserPlaylists(): void {
    this.isLoadingPlaylists = true;

    // Subscribe to userUsageData observable to get continuously updated data
    this.subscriptions.push(
      this.userService.userUsageData.subscribe((userData) => {
        if (userData && userData.createdPlaylistIds && userData.createdPlaylistIds.length > 0) {
          // Get playlist details for user's playlists
          this.playlistService.getPlaylistByIds(userData.createdPlaylistIds).subscribe(
            (playlistsResponse) => {
              if (playlistsResponse && playlistsResponse.data) {
                this.userPlaylists = playlistsResponse.data;
              }
              this.isLoadingPlaylists = false;
            },
            (error) => {
              console.error('Error loading user playlists:', error);
              this.isLoadingPlaylists = false;
            }
          );
        } else {
          this.isLoadingPlaylists = false;
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

  // Get radio description for a track
  getRadioDescription(track: EnhancedTrackDto): string {
    if (track.artists && track.artists.length > 1) {
      const others = track.artists
        .filter((a) => !a.isMainArtist)
        .slice(0, 2)
        .map((a) => a.name);
      return others.length > 0 ? `With ${others.join(', ')}` : 'With similar artists';
    }
    return 'With similar artists';
  }

  /**
   * Truncates text if it exceeds the maximum length
   * @param text The text to truncate
   * @param maxLength Maximum length before truncation
   * @returns Truncated text with ellipsis or original text
   */
  truncateText(text: string, maxLength: number = 25): string {
    if (!text) return '';
    return text.length > maxLength ? text.substring(0, maxLength) + '...' : text;
  }

  // Handle filter tab click
  setActiveFilter(filter: string): void {
    this.activeFilter = filter;
  }

  // Navigate to section page for "Show all" links
  goToSection(sectionType: string): void {
    this.router.navigate(['/section', sectionType]);
  }
}
