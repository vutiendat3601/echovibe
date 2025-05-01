import { SearchService } from './../../../service/search.service';
import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Subscription } from 'rxjs';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlay, faUser, faClock, faMusic } from '@fortawesome/free-solid-svg-icons';
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

  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly searchService: SearchService,
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

  private loadMockData(): void {
    this.isLoading = true;

    // Simulate API loading delay
    setTimeout(() => {
      // We no longer use mock artists data - we get real data from the API
      this.isLoading = false;
    }, 800);
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
    this.isLoading = true;

    const searchSub = this.searchService.search(this.searchKeyword, this.pageNumber, this.PAGE_SIZE).subscribe({
      next: (respDto) => {
        if (respDto.data) {
          const search = respDto.data;
          const artists = search.artist.items.map((artistDetailDto: ArtistDetailDto) => artistDetailDto as Artist);

          // Add new artists to existing list
          this.artists = [...this.artists, ...artists];
          this.pageNumber++;
          console.log('Loaded more artists, total:', this.artists.length);
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
    this.router.navigate(['/artist', artist.id]);
  }
}
