import { CommonModule } from '@angular/common';
import { Component, OnInit, HostListener } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { RouterModule } from '@angular/router';
import { MenuItem } from 'primeng/api';
import { AvatarModule } from 'primeng/avatar';
import { StyleClassModule } from 'primeng/styleclass';
import { UserProfile } from '../../../model/user-profile';
import { AuthService } from '../../../service/auth.service';
import { LayoutService } from '../../service/layout.service';
import { ConfiguratorComponent } from '../configurator/configurator.component';
import { InputTextModule } from 'primeng/inputtext';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { Subject, debounceTime, distinctUntilChanged } from 'rxjs';
import { RecentSearchType } from '../../../constant/recent-search-type';
import { SearchService } from '../../../service/search.service';
import { UserService } from '../../../service/user.service';
import { UserRecentSearchDto } from '../../../dto/user-dto';

interface TopBarActionMenuItem {
  [key: string]: MenuItem;
}

interface RecentSearch {
  aggregateId: string;
  name: string;
  thumbnailUrl: string | null;
  path: string;
  type: RecentSearchType;
}

@Component({
  selector: 'app-top-bar',
  standalone: true,
  imports: [
    RouterModule,
    CommonModule,
    StyleClassModule,
    ConfiguratorComponent,
    AvatarModule,
    InputTextModule,
    IconFieldModule,
    InputIconModule,
    FormsModule
  ],
  templateUrl: './top-bar.component.html',
  styleUrl: './top-bar.component.scss'
})
export class TopBarComponent implements OnInit {
  items!: MenuItem[];
  userProfile: UserProfile = {};
  actionMenuItems: TopBarActionMenuItem = { profile: { label: $localize`:@@MENU_ITEM_LABEL_USER_PROFILE:Profile` } };

  // Search related properties
  searchQuery: string = '';
  isSearchFocused: boolean = false;
  private searchInputSubject = new Subject<string>();

  recentSearches: RecentSearch[] | null = null;

  constructor(
    public readonly layoutService: LayoutService,
    public readonly authService: AuthService,
    private readonly userService: UserService,
    private readonly searchService: SearchService,
    private readonly router: Router
  ) {
    // Set up debounce for search input
    this.searchInputSubject
      .pipe(
        debounceTime(300), // Wait for 300ms pause in events
        distinctUntilChanged() // Only emit if value is different from previous
      )
      .subscribe((query) => {
        if (query && query.trim().length > 1) {
          this.navigateToSearchDetail(query);
        }
      });
  }

  ngOnInit(): void {
    // Subscribe to user profile changes
    this.authService.userProfile().subscribe((userProfile) => (this.userProfile = userProfile));
    this.loadData();
  }

  // Keyboard shortcut handler for Ctrl+K
  @HostListener('window:keydown', ['$event'])
  handleKeyboardEvent(event: KeyboardEvent) {
    if (event.ctrlKey && event.key === 'k') {
      event.preventDefault();
      this.focusSearch();
    }
  }

  focusSearch() {
    // Find the search input and focus it
    const searchInput = document.querySelector('.search-input') as HTMLInputElement;
    if (searchInput) {
      searchInput.focus();
    }
  }

  onSearchFocus() {
    this.isSearchFocused = true;
  }

  onSearchBlur() {
    // Small delay to allow click events on dropdown items to fire before closing
    setTimeout(() => {
      this.isSearchFocused = false;
    }, 200);
  }

  // New method to handle input events and trigger search as user types
  onSearchInput() {
    this.searchInputSubject.next(this.searchQuery);
  }

  navigateToSearch() {
    if (this.searchQuery.trim()) {
      // Add to recent searches if it doesn't exist
      this.saveToRecentSearches();
      this.navigateToSearchDetail(this.searchQuery);
    }
  }

  navigateToSearchDetail(query: string) {
    // Navigate to search page with the query
    this.router.navigate(['/search', query]);
  }

  selectRecentSearch(recentSearch: RecentSearch) {
    // if (result.type === 'artist') {
    //   this.router.navigate(['/artist', result.id]);
    // } else if (result.type === 'song') {
    //   // Save to recent searches
    //   this.saveToRecentSearches(result);
    //   this.router.navigate(['/search', result.title]);
    // } else {
    //   this.router.navigate(['/search', result.title]);
    // }
    this.router.navigate([recentSearch.path]);
  }

  private saveToRecentSearches(result?: RecentSearch) {
    // If a result is provided, use it, otherwise create one from the query
    // if (!result && this.searchQuery.trim()) {
    //   // For simplicity, create a generic result
    //   const newResult: RecentSearch = {
    //     title: this.searchQuery,
    //     artist: 'Search query',
    //     imageUrl: '/asset/image/default-artist-thumbnail-image.svg',
    //     type: 'song',
    //     id: Date.now().toString()
    //   };
    //   // Add to recent searches (limit to 10)
    //   this.recentSearches = [newResult, ...this.recentSearches].slice(0, 10);
    // }
  }

  clearRecentSearches(event: Event): void {
    // Prevent the dropdown from closing when clicking the button
    event.preventDefault();
    event.stopPropagation();

    // Clear the recent searches array
    this.recentSearches = [];
    this.searchService.updateRecentSearches([]);

    // In a real application, you would also persist this to local storage or a backend service
    // localStorage.removeItem('recentSearches');
  }

  toggleDarkMode(): void {
    this.layoutService.layoutConfig.update((state) => ({ ...state, darkTheme: !state.darkTheme }));
  }

  redirectToProfileUrl(): void {}

  signIn(): void {
    this.authService.signIn();
  }

  signOut(): void {
    // First sign out using the AuthService
    this.authService.signOut();
  }

  private loadData(): void {
    this.userService.userUsageData.subscribe(
      ({ recentSearches }) => (this.recentSearches = recentSearches.map((rc) => this.mapToRecentSearch(rc)))
    );
    this.userService.refresh();
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
