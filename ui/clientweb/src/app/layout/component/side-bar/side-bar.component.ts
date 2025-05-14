import { Component, ElementRef, ViewChild, HostListener, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { MenuComponent } from '../menu/menu.component';
import { PopoverModule } from 'primeng/popover';
import { Popover } from 'primeng/popover';
import { ButtonModule } from 'primeng/button';
import { ContextMenuModule } from 'primeng/contextmenu';
import { MenuItem } from 'primeng/api';
import { PlaylistService } from '../../../service/playlist.service';
import { UserService } from '../../../service/user.service';
import { CreatePlaylistDto, UpdatePlaylistDto, PlaylistDetailDto } from '../../../dto/playlist-dto';
import { MessageService, ConfirmationService } from 'primeng/api';
import { ToastModule } from 'primeng/toast';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { MenuModule } from 'primeng/menu';
import { TooltipModule } from 'primeng/tooltip';
import { InputTextModule } from 'primeng/inputtext';
import { EditPlaylistDialogComponent } from '../../../component/edit-playlist-dialog/edit-playlist-dialog.component';
import { AuthService } from '../../../service/auth.service'; // Add AuthService import
import { InputIcon } from 'primeng/inputicon';
import { IconField } from 'primeng/iconfield';

interface Member {
  name: string;
  image: string;
  email: string;
  role: string;
}

@Component({
  selector: 'app-side-bar',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MenuComponent,
    PopoverModule,
    ButtonModule,
    ContextMenuModule,
    ToastModule,
    ConfirmDialogModule,
    EditPlaylistDialogComponent,
    TooltipModule,
    MenuModule,
    InputTextModule,
    InputIcon,
    IconField
  ],
  templateUrl: './side-bar.component.html',
  styleUrls: ['./side-bar.component.scss'],
  providers: [MessageService, ConfirmationService]
})
export class SideBarComponent implements OnInit, OnDestroy {
  likedSongsCount = 1;
  activeTab: string = 'playlists'; // Track active tab: 'playlists', 'artists', or 'mysongs'
  artists = [
    { name: 'Sơn Tùng M-TP', imageUrl: 'asset/image/default-artist-thumbnail-image.svg' },
    { name: 'ANH TRAI "SAY HI"', imageUrl: 'asset/image/default-artist-thumbnail-image.svg' }
  ];

  // Property to store user playlists
  playlists: PlaylistDetailDto[] = [];

  isCreateMenuVisible = false;
  @ViewChild('createMenu') createMenu!: ElementRef;
  @ViewChild('op') op!: Popover;

  // Context menu for playlists
  playlistContextMenuItems: MenuItem[] = [];
  selectedPlaylist: PlaylistDetailDto | null = null;

  // Edit playlist dialog visibility control
  showEditPlaylistDialog: boolean = false;

  // Sorting options
  currentSortOption: string = 'Recents';
  sortMenuItems: MenuItem[] = [
    {
      label: 'Recents',
      command: () => {
        this.sortPlaylists('recent');
        this.currentSortOption = 'Recents';
      }
    },
    {
      label: 'Alpha',
      command: () => {
        this.sortPlaylists('alpha');
        this.currentSortOption = 'Alpha';
      }
    },
    {
      label: 'Creator',
      command: () => {
        this.sortPlaylists('creator');
        this.currentSortOption = 'Creator';
      }
    }
  ];

  constructor(
    public el: ElementRef,
    private router: Router,
    private playlistService: PlaylistService,
    private userService: UserService,
    private messageService: MessageService,
    private confirmationService: ConfirmationService,
    public authService: AuthService
  ) {}

  ngOnInit(): void {
    // Check current route to set active tab on initialization
    const currentUrl = this.router.url;
    if (currentUrl.includes('offline-library')) {
      this.activeTab = 'mysongs';
    } else if (currentUrl.includes('artist')) {
      this.activeTab = 'artists';
    } else {
      this.activeTab = 'playlists';
    }

    // Initial load of playlists
    this.loadPlaylists();

    // Update liked songs count
    this.updateLikedSongsCount();

    this.listenDataChange();

    // Initialize context menu items
    this.initializeContextMenu();
    this.userService.refresh();
  }

  setActiveTab(tab: string): void {
    this.activeTab = tab;
  }

  initializeContextMenu(): void {
    this.playlistContextMenuItems = [
      {
        label: 'Play',
        icon: 'pi pi-play',
        command: () => this.playPlaylist()
      },
      {
        label: 'Add to Queue',
        icon: 'pi pi-list',
        command: () => this.addPlaylistToQueue()
      },
      {
        separator: true
      },
      {
        label: 'Edit Details',
        icon: 'pi pi-pencil',
        command: () => this.editPlaylistDetails()
      },
      {
        label: 'Delete',
        icon: 'pi pi-trash',
        command: () => this.deletePlaylist()
      }
    ];
  }

  onPlaylistContextMenu(event: MouseEvent, playlist: PlaylistDetailDto): void {
    // Prevent the default context menu
    event.preventDefault();
    // Store the selected playlist
    this.selectedPlaylist = playlist;
  }

  loadPlaylists(): void {
    // this.userService.userUsageData.subscribe((userData) => {
    //   if (
    //     userData &&
    //     userData.createdPlaylistIds.length &&
    //     userData.createdPlaylistIds.length != this.playlists.length
    //   ) {
    //     // Get detailed information for each playlist
    //     this.playlistService.getPlaylistByIds(userData.createdPlaylistIds).subscribe({
    //       next: (response) => {
    //         if (response.data) {
    //           this.playlists = response.data.filter((playlist) => playlist != null);
    //         }
    //       },
    //       error: (error) => {
    //         console.error('Error loading playlists:', error);
    //       }
    //     });
    //   }
    // });
  }

  // Update liked songs count from user data
  updateLikedSongsCount(): void {
    this.userService.userUsageData.subscribe((userData) => {
      if (userData && userData.likedTrackIds) {
        this.likedSongsCount = userData.likedTrackIds.length;
      }
    });
  }

  toggle(event: Event): void {
    this.op.toggle(event);
  }

  handleCreatePlaylist(): void {
    // Hide popover
    this.op.hide();

    // Create a new playlist with default values
    const newPlaylist: CreatePlaylistDto = {
      name: 'My Playlist #' + Math.floor(Math.random() * 100),
      trackIds: [],
      isPublic: true,
      thumbnailUrl: null
    };

    // Send create playlist request
    this.playlistService.createPlaylist(newPlaylist);
  }

  // Methods for context menu actions
  playPlaylist(): void {
    // if (!this.selectedPlaylist) return;
    // this.playlistService.playPlaylist(this.selectedPlaylist.id).subscribe({
    //   next: (response) => {
    //     if (response.data) {
    //       this.messageService.add({
    //         severity: 'success',
    //         summary: 'Playing',
    //         detail: `Playing playlist "${this.selectedPlaylist?.name}"`
    //       });
    //     } else {
    //       this.messageService.add({
    //         severity: 'error',
    //         summary: 'Error',
    //         detail: response.message
    //       });
    //     }
    //   },
    //   error: (error) => {
    //     console.error('Error playing playlist:', error);
    //     this.messageService.add({
    //       severity: 'error',
    //       summary: 'Error',
    //       detail: 'Failed to play playlist'
    //     });
    //   }
    // });
  }

  addPlaylistToQueue(): void {
    // if (!this.selectedPlaylist) return;
    // this.playlistService.addPlaylistToQueue(this.selectedPlaylist.id).subscribe({
    //   next: (response) => {
    //     if (response.data) {
    //       this.messageService.add({
    //         severity: 'success',
    //         summary: 'Added to Queue',
    //         detail: `"${this.selectedPlaylist?.name}" has been added to your queue`
    //       });
    //     } else {
    //       this.messageService.add({
    //         severity: 'error',
    //         summary: 'Error',
    //         detail: response.message
    //       });
    //     }
    //   },
    //   error: (error) => {
    //     console.error('Error adding playlist to queue:', error);
    //     this.messageService.add({
    //       severity: 'error',
    //       summary: 'Error',
    //       detail: 'Failed to add playlist to queue'
    //     });
    //   }
    // });
  }

  editPlaylistDetails(): void {
    if (!this.selectedPlaylist) return;
    // Show the edit playlist dialog
    this.showEditPlaylistDialog = true;
  }

  // Handle playlist updated event from the dialog
  handlePlaylistUpdated(updatedPlaylist: PlaylistDetailDto): void {
    // Create the update DTO
    const updateDto: UpdatePlaylistDto = {
      id: updatedPlaylist.id,
      name: updatedPlaylist.name,
      trackIds: updatedPlaylist.tracks.map((track) => track.id),
      isPublic: updatedPlaylist.isPublic,
      thumbnailUrl: updatedPlaylist.thumbnailUrl ? updatedPlaylist.thumbnailUrl.toString() : null
    };

    // Send the update
    this.playlistService.updatePlaylist(updateDto);

    this.messageService.add({
      severity: 'success',
      summary: 'Playlist Updated',
      detail: `"${updatedPlaylist.name}" has been updated successfully`
    });
  }

  deletePlaylist(): void {
    if (!this.selectedPlaylist) return;

    this.confirmationService.confirm({
      header: 'Confirm Deletion',
      message: `Are you sure you want to delete "${this.selectedPlaylist.name}"?`,
      icon: 'pi pi-exclamation-triangle',
      acceptButtonStyleClass: 'p-button-danger',
      acceptIcon: 'pi pi-trash',
      accept: () => {
        // Store the playlist name for the success message
        const playlistName = this.selectedPlaylist!.name;
        const playlistId = this.selectedPlaylist!.id;

        // Call the deletePlaylist method from the service
        this.playlistService.deletePlaylist(playlistId);

        // Remove deleted playlist from the local list
        this.playlists = this.playlists.filter((p) => p.id !== playlistId);

        // Clear the selected playlist
        this.selectedPlaylist = null;

        // Show success message
        this.messageService.add({
          severity: 'success',
          summary: 'Deleted',
          detail: `"${playlistName}" has been deleted`
        });

        // Reload the playlist list to reflect the change in the UI
        setTimeout(() => this.loadPlaylists(), 1000);
      }
    });
  }

  // Method to filter playlists by name
  filterPlaylists(searchTerm: string): void {
    // Implementation of playlist filtering logic
    if (!searchTerm) {
      // If search term is empty, load all playlists
      this.loadPlaylists();
    } else {
      // Filter playlists by name (case insensitive)
      // This is a client-side filtering - for larger datasets, should be server-side
      const term = searchTerm.toLowerCase();
      this.userService.userUsageData.subscribe((userData) => {
        if (userData && userData.createdPlaylistIds && userData.createdPlaylistIds.length > 0) {
          // Get all playlists and then filter them
          this.playlistService.getPlaylistByIds(userData.createdPlaylistIds).subscribe({
            next: (response) => {
              if (response.data) {
                this.playlists = response.data.filter((playlist) => playlist.name.toLowerCase().includes(term));
              }
            },
            error: (error) => {
              console.error('Error loading playlists:', error);
            }
          });
        }
      });
    }
  }

  // Method to sort playlists (recent, alpha, etc)
  sortPlaylists(sortOption: 'recent' | 'alpha' | 'creator'): void {
    // Sort the existing playlist array based on the selected option
    switch (sortOption) {
      case 'recent':
        // Sort by creation date (newest first)
        this.playlists.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
        break;
      case 'alpha':
        // Sort alphaly by name
        this.playlists.sort((a, b) => a.name.localeCompare(b.name));
        break;
      case 'creator':
        // Sort by creator name
        this.playlists.sort((a, b) => a.createdBy.localeCompare(b.createdBy));
        break;
    }
  }

  // Cycle through sort options: Recent -> Alpha -> Creator -> Recent...
  cycleSortOption(): void {
    switch (this.currentSortOption) {
      case 'Recents':
        this.currentSortOption = 'Alpha';
        this.sortPlaylists('alpha');
        break;
      case 'Alpha':
        this.currentSortOption = 'Creator';
        this.sortPlaylists('creator');
        break;
      default:
        this.currentSortOption = 'Recents';
        this.sortPlaylists('recent');
        break;
    }
  }

  // Update a playlist when it's been modified (either created, updated or deleted)
  updatePlaylistHandler(): void {
    // Refresh the playlists list
    this.loadPlaylists();

    // Close the edit dialog if it's open
    this.showEditPlaylistDialog = false;

    // Clear the selected playlist
    this.selectedPlaylist = null;
  }

  private listenDataChange() {
    // Listen for created playlist events
    this.userService.userUsageData.subscribe(({ createdPlaylistIds }) => {
      if (createdPlaylistIds && createdPlaylistIds.length && createdPlaylistIds.length != this.playlists.length) {
        window.setTimeout(() => {
          this.playlistService.getPlaylistByIds(createdPlaylistIds).subscribe({
            next: (response) => {
              if (response.data) {
                this.playlists = response.data.filter((playlist) => playlist != null);
              }
            },
            error: (error) => {
              console.error('Error loading playlists:', error);
            }
          });
        }, 2_000);
      }
    });

    this.playlistService.createdPlaylistId.subscribe((playlistId) => {
      this.router.navigate([`/playlist/${playlistId}`]);
    });
  }

  ngOnDestroy(): void {}

  // Method to handle login when user is not authenticated
  signIn(): void {
    this.authService.signIn();
  }
}
