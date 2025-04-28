import { SearchService } from './../../../service/search.service';
import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Subscription } from 'rxjs';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay, faUser, faClock, faMusic } from '@fortawesome/free-solid-svg-icons';
// import { ArtistMapper } from '../../../mapper/artist-mapper';
import { ArtistDetailDto } from '../../../dto/artist-dto';

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

// Mock data interfaces
interface MockSong {
  id: string;
  title: string;
  artist: string;
  featuredArtist?: string;
  albumImage: string;
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

@Component({
  selector: 'app-search-detail',
  standalone: true,
  imports: [CommonModule, FormsModule, FontAwesomeModule],
  templateUrl: './search-detail.component.html',
  styleUrl: './search-detail.component.scss'
})
export class SearchDetailComponent implements OnInit, OnDestroy {
  private readonly PAGE_SIZE: number = 100;
  pageNumber: number = 0;
  artists: Artist[] = [];
  isLoading: boolean = false;
  searchKeyword: string = '';
  activeFilter: string = 'all'; // Default filter
  private subscriptions: Subscription[] = [];

  // Icons
  faPlay = faPlay;
  faUser = faUser;
  faClock = faClock;
  faMusic = faMusic;

  // Mock data
  mockSongs: MockSong[] = [
    {
      id: '1',
      title: 'Show Yourself',
      artist: 'Deftones',
      albumImage: '/asset/image/default-artist-thumbnail-image.png',
      duration: '3:46',
      explicit: true
    },
    {
      id: '2',
      title: 'Change (In the House of Flies)',
      artist: 'Deftones',
      albumImage: '/asset/image/default-artist-thumbnail-image.png',
      duration: '4:58',
      explicit: true
    },
    {
      id: '3',
      title: 'My Own Summer (Shove It)',
      artist: 'Deftones',
      albumImage: '/asset/image/default-artist-thumbnail-image.png',
      duration: '3:35',
      explicit: false
    },
    {
      id: '4',
      title: 'Be Quiet and Drive (Far Away)',
      artist: 'Deftones',
      featuredArtist: 'The Cure',
      albumImage: '/asset/image/default-artist-thumbnail-image.png',
      duration: '5:08',
      explicit: true
    }
  ];

  mockPlaylists: MockPlaylist[] = [
    {
      id: '1',
      title: 'This is Deftones',
      description: 'By Spotify',
      coverImage: '/asset/image/default-artist-thumbnail-image.png',
      type: 'Playlist',
      badge: 'SPOTIFY'
    },
    {
      id: '2',
      title: 'Deftones Radio',
      description: 'With Korn, System of a Down',
      coverImage: '/asset/image/default-artist-thumbnail-image.png',
      type: 'Radio',
      badge: 'RADIO'
    },
    {
      id: '3',
      title: 'Alternative Metal',
      description: 'Best of alternative metal',
      coverImage: '/asset/image/default-artist-thumbnail-image.png',
      type: 'Playlist'
    },
    {
      id: '4',
      title: 'Rock Classics',
      description: 'Rock hits from all decades',
      coverImage: '/asset/image/default-artist-thumbnail-image.png',
      type: 'Playlist'
    }
  ];
  mockArtists: Artist[] = [
    {
      id: '1',
      urn: 'urn:artist:1',
      name: 'Deftones',
      thumbnailUrl: '/asset/image/default-artist-thumbnail-image.png',
      description: 'American alternative metal band',
      backgroundUrl: '/asset/image/default-artist-thumbnail-image.png',
      biography: 'Deftones are an American alternative metal band formed in 1988.',
      nationalityIsoCode: 'US',
      isPublic: true,
      isVerified: true,
      tags: []
    },
    {
      id: '2',
      urn: 'urn:artist:1',
      name: 'Deftones',
      thumbnailUrl: '/asset/image/default-artist-thumbnail-image.png',
      description: 'American alternative metal band',
      backgroundUrl: '/asset/image/default-artist-thumbnail-image.png',
      biography: 'Deftones are an American alternative metal band formed in 1988.',
      nationalityIsoCode: 'US',
      isPublic: true,
      isVerified: true,
      tags: []
    }
  ];

  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly searchService: SearchService
    // private readonly artistMapper: ArtistMapper
  ) {}

  ngOnInit(): void {
    // Use mock data instead of API call
    this.loadMockData();
    this.loadData();
  }

  ngOnDestroy(): void {
    // Clean up subscriptions
    this.subscriptions.forEach((sub) => sub.unsubscribe());
  }

  setActiveFilter(filter: string): void {
    this.activeFilter = filter;
    // In a real implementation, you would reload data based on the filter
  }

  private loadMockData(): void {
    const paramsSub = this.activeRoute.params.subscribe((params) => {
      if (params['keyword']) {
        this.searchKeyword = params['keyword'];
        this.isLoading = true;

        // Simulate API loading delay
        setTimeout(() => {
          this.artists = this.mockArtists;
          this.isLoading = false;
        }, 800);
      }
    });

    this.subscriptions.push(paramsSub);
  }

  private loadData(): void {
    // Reset page number and artists when loading new data
    this.pageNumber = 0;
    this.artists = [];

    const paramsSub = this.activeRoute.params.subscribe((params) => {
      if (params['keyword']) {
        this.searchKeyword = params['keyword'];
        this.isLoading = true;

        const searchSub = this.searchService.search(params['keyword'], this.pageNumber, this.PAGE_SIZE).subscribe({
          next: (respDto) => {
            if (respDto.data) {
              const search = respDto.data;
              // Use the artistMapper to properly convert from ArtistDetailDto to Artist
              const artists = search.artist.items.map((artistDetailDto: ArtistDetailDto) => artistDetailDto as Artist);
              this.artists = [...this.artists, ...artists];
              this.pageNumber++;
              console.log('Loaded artists:', this.artists);
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

    this.subscriptions.push(paramsSub);
  }

  loadMoreResults(): void {
    // Simulate loading more results
    this.isLoading = true;

    setTimeout(() => {
      // Nothing to do for mock data, but we'll simulate the loading
      this.isLoading = false;
    }, 800);
  }

  navigateToArtist(artist: Artist): void {
    // To be implemented - navigate to artist detail page
    console.log('Navigate to artist:', artist);
  }
}
