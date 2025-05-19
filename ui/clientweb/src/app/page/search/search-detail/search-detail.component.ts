import { UserService } from './../../../service/user.service';
import { SearchService } from './../../../service/search.service';
import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Subscription } from 'rxjs';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay, faUser, faClock, faMusic } from '@fortawesome/free-solid-svg-icons';
import { ArtistDetailDto } from '../../../dto/artist-dto';
import { TrackDetailDto } from '../../../dto/track-dto';
import { RecentSearchType } from '../../../constant/recent-search-type';
import { UserRecentSearchDto } from '../../../dto/user-dto';
import { AudioDurationPipe } from '../../../pipe/audio-duration.pipe';

interface Artist {
  id: string;
  urn: string;
  name: string;
  description: string | null;
  biography: string | null;
  nationalityIsoCode: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  isPublic: boolean;
  isVerified: boolean;
  tags: string[];
}

// Interface for displaying track data
interface DisplayTrack {
  id: string;
  title: string;
  artist: string;
  featuredArtists?: string;
  thumbnailUrl: string;
  duration: string;
  explicit: boolean;
}

interface MockPlaylist {
  id: string;
  title: string;
  description: string;
  coverImage: string;
  type: string;
  badge?: string;
}

interface RecentSearch {
  aggregateId: string;
  name: string;
  thumbnailUrl: string | null;
  path: string;
  type: RecentSearchType;
}

@Component({
  selector: 'app-search-detail',
  standalone: true,
  imports: [CommonModule, FormsModule, FontAwesomeModule, AudioDurationPipe],
  templateUrl: './search-detail.component.html',
  styleUrl: './search-detail.component.scss'
})
export class SearchDetailComponent implements OnInit, OnDestroy {
  private readonly PAGE_SIZE: number = 100;
  pageNumber: number = 0;
  artists: Artist[] = [];
  tracks: TrackDetailDto[] = [];
  isLoading: boolean = false;
  searchKeyword: string = '';
  activeFilter: string = 'all'; // Default filter
  recentSearches: RecentSearch[] | null = null;
  private subscriptions: Subscription[] = [];

  // Icons
  faPlay = faPlay;
  faUser = faUser;
  faClock = faClock;
  faMusic = faMusic;

  // Mock playlists (will replace with real data later)
  mockPlaylists: MockPlaylist[] = [
    {
      id: '1',
      title: 'This is Deftones',
      description: 'By Spotify',
      coverImage: '/asset/image/default-artist-thumbnail-image.svg',
      type: 'Playlist',
      badge: 'SPOTIFY'
    },
    {
      id: '2',
      title: 'Deftones Radio',
      description: 'With Korn, System of a Down',
      coverImage: '/asset/image/default-artist-thumbnail-image.svg',
      type: 'Radio',
      badge: 'RADIO'
    },
    {
      id: '3',
      title: 'Alternative Metal',
      description: 'Best of alternative metal',
      coverImage: '/asset/image/default-artist-thumbnail-image.svg',
      type: 'Playlist'
    },
    {
      id: '4',
      title: 'Rock Classics',
      description: 'Rock hits from all decades',
      coverImage: '/asset/image/default-artist-thumbnail-image.svg',
      type: 'Playlist'
    }
  ];

  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly searchService: SearchService,
    private readonly userService: UserService,
    private readonly router: Router
  ) {}

  ngOnInit(): void {
    // Subscribe to route parameters to get the filter
    this.activeRoute.params.subscribe((params) => {
      if (params['keyword']) {
        this.searchKeyword = params['keyword'];

        // Set active filter based on the route parameter
        if (params['filter']) {
          this.activeFilter = params['filter'];
        } else {
          this.activeFilter = 'all';
        }

        // Load real data instead of mock data
        this.loadData();
      }
    });
  }

  ngOnDestroy(): void {
    // Clean up subscriptions
    this.subscriptions.forEach((sub) => sub.unsubscribe());
  }

  setActiveFilter(filter: string): void {
    this.activeFilter = filter;
    // Navigate to the new route with the selected filter
    if (filter === 'all') {
      this.router.navigate(['/search', this.searchKeyword]);
    } else {
      this.router.navigate(['/search', this.searchKeyword, filter]);
    }
  }

  private loadData(): void {
    // Reset page number, artists and tracks when loading new data
    this.pageNumber = 0;
    this.artists = [];
    this.tracks = [];

    const paramsSub = this.activeRoute.params.subscribe((params) => {
      if (params['keyword']) {
        this.searchKeyword = params['keyword'];
        this.isLoading = true;

        const searchSub = this.searchService.search(params['keyword'], this.pageNumber, this.PAGE_SIZE).subscribe({
          next: (respDto) => {
            if (respDto.data) {
              const search = respDto.data;

              // Process artists data
              const artists = search.artist.items.map((artistDetailDto: ArtistDetailDto) => artistDetailDto as Artist);
              this.artists = [...this.artists, ...artists];

              // Process tracks data
              const tracks = search.track.items.map((trackDto: TrackDetailDto) => trackDto);
              this.tracks = [...this.tracks, ...tracks];

              this.pageNumber++;
            }
            this.isLoading = false;
          },
          error: (err) => {
            console.error('Error fetching search results:', err);
            this.isLoading = false;
          }
        });

        this.subscriptions.push(searchSub);
      }
    });

    this.userService.userUsageData.subscribe(
      ({ recentSearches }) => (this.recentSearches = recentSearches.map((rc) => this.mapToRecentSearch(rc)))
    );
    this.userService.refresh();

    this.subscriptions.push(paramsSub);
  }

  loadMoreResults(): void {
    this.isLoading = true;

    const searchSub = this.searchService.search(this.searchKeyword, this.pageNumber, this.PAGE_SIZE).subscribe({
      next: (respDto) => {
        if (respDto.data) {
          const search = respDto.data;

          // Process artists data
          const artists = search.artist.items.map((artistDetailDto: ArtistDetailDto) => artistDetailDto as Artist);
          this.artists = [...this.artists, ...artists];

          // Process tracks data
          const tracks = search.track.items.map((trackDto: TrackDetailDto) => trackDto);
          this.tracks = [...this.tracks, ...tracks];

          this.pageNumber++;
          console.log('Loaded more data, artists total:', this.artists.length, 'tracks total:', this.tracks.length);
        }
        this.isLoading = false;
      },
      error: (err) => {
        console.error('Error fetching additional search results:', err);
        this.isLoading = false;
      }
    });

    this.subscriptions.push(searchSub);
  }

  navigateToArtist(artist: Artist): void {
    // Navigate to artist detail page using the artist's id
    if (this.recentSearches) {
      this.searchService.updateRecentSearches([
        {
          aggregateId: artist.id,
          name: artist.name,
          thumbnailUrl: artist.thumbnailUrl,
          type: RecentSearchType.ARTIST
        },
        ...this.recentSearches.map(({ aggregateId, name, thumbnailUrl, type }) => ({
          aggregateId,
          name,
          thumbnailUrl,
          type
        }))
      ]);
    }
    this.router.navigate(['/artist', artist.id]);
  }

  navigateToTrack(track: TrackDetailDto): void {
    // Navigate to track detail page using the track's id
    if (this.recentSearches) {
      this.searchService.updateRecentSearches([
        {
          aggregateId: track.id,
          name: track.name,
          thumbnailUrl: track.thumbnailUrl,
          type: RecentSearchType.TRACK
        },
        ...this.recentSearches.map(({ aggregateId, name, thumbnailUrl, type }) => ({
          aggregateId,
          name,
          thumbnailUrl,
          type
        }))
      ]);
      this.router.navigate(['/track', track.id]);
    }
  }

  private mapToRecentSearch({ aggregateId, name, type, thumbnailUrl }: UserRecentSearchDto): RecentSearch {
    let path = '/';
    if (type === RecentSearchType.ARTIST) {
      path = `/artist/${aggregateId}`;
    } else if (type === RecentSearchType.TRACK) {
      path = `/track/${aggregateId}`;
    } else if (type === RecentSearchType.PLAYLIST) {
      path = `/playlist/${aggregateId}`;
    }

    return {
      aggregateId,
      path,
      type,
      thumbnailUrl,
      name
    };
  }
}
