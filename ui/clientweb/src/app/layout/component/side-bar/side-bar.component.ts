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
import { PlaylistDto } from '../../../dto/playlist-dto';
import { Subscription } from 'rxjs';
import { MessageService, ConfirmationService } from 'primeng/api';
import { ToastModule } from 'primeng/toast';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { EditPlaylistDialogComponent } from '../../../component/edit-playlist-dialog/edit-playlist-dialog.component';

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
    EditPlaylistDialogComponent
  ],
  templateUrl: './side-bar.component.html',
  styleUrls: ['./side-bar.component.scss'],
  providers: [MessageService, ConfirmationService]
})
export class SideBarComponent implements OnInit, OnDestroy {
  likedSongsCount = 1;
  activeTab: string = 'playlists'; // Track active tab: 'playlists', 'artists', or 'mysongs'
  artists = [
    { name: 'Sơn Tùng M-TP', imageUrl: 'assets/image/default-artist-thumbnail-image.png' },
    { name: 'ANH TRAI "SAY HI"', imageUrl: 'assets/image/default-artist-thumbnail-image.png' }
  ];

  // Add playlists property to store user playlists
  playlists: PlaylistDto[] = [];
  private subscription: Subscription = new Subscription();

  isCreateMenuVisible = false;
  @ViewChild('createMenu') createMenu!: ElementRef;
  @ViewChild('op') op!: Popover;

  // Context menu for playlists
  playlistContextMenuItems: MenuItem[] = [];
  selectedPlaylist: PlaylistDto | null = null;

  // Edit playlist dialog visibility control
  showEditPlaylistDialog: boolean = false;

  constructor(
    public el: ElementRef,
    private router: Router,
    private playlistService: PlaylistService,
    private messageService: MessageService,
    private confirmationService: ConfirmationService
  ) {}

  ngOnInit(): void {
    // Subscribe to playlists observable to get real-time updates
    this.subscription.add(
      this.playlistService.playlists$.subscribe(playlists => {
        this.playlists = playlists;
      })
    );

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

    // Initialize context menu items
    this.initializeContextMenu();
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

  onPlaylistContextMenu(event: MouseEvent, playlist: PlaylistDto): void {
    // Prevent the default context menu
    event.preventDefault();
    // Store the selected playlist
    this.selectedPlaylist = playlist;
  }

  loadPlaylists(): void {
    this.playlistService.getPlaylists().subscribe({
      next: (response) => {
        if (response.data) {
          this.playlists = response.data;
        }
      },
      error: (error) => {
        console.error('Error loading playlists:', error);
      }
    });
  }

  toggle(event: Event): void {
    this.op.toggle(event);
  }

  handleCreatePlaylist(): void {
    // Hide popover
    this.op.hide();

    // Create a new playlist and navigate to it
    this.playlistService.createPlaylist('My Playlist #' + Math.floor(Math.random() * 100)).subscribe({
      next: (response) => {
        if (response.data) {
          // Navigate to the new playlist
          this.router.navigate([`/playlist/${response.data.id}`]);
        }
      },
      error: (error) => {
        console.error('Error creating playlist:', error);
      }
    });
  }

  // Methods for context menu actions
  playPlaylist(): void {
    if (!this.selectedPlaylist) return;

    this.playlistService.playPlaylist(this.selectedPlaylist.id).subscribe({
      next: (response) => {
        if (response.data) {
          this.messageService.add({
            severity: 'success',
            summary: 'Playing',
            detail: `Playing playlist "${this.selectedPlaylist?.name}"`
          });
        } else {
          this.messageService.add({
            severity: 'error',
            summary: 'Error',
            detail: response.message
          });
        }
      },
      error: (error) => {
        console.error('Error playing playlist:', error);
        this.messageService.add({
          severity: 'error',
          summary: 'Error',
          detail: 'Failed to play playlist'
        });
      }
    });
  }

  addPlaylistToQueue(): void {
    if (!this.selectedPlaylist) return;

    this.playlistService.addPlaylistToQueue(this.selectedPlaylist.id).subscribe({
      next: (response) => {
        if (response.data) {
          this.messageService.add({
            severity: 'success',
            summary: 'Added to Queue',
            detail: `"${this.selectedPlaylist?.name}" has been added to your queue`
          });
        } else {
          this.messageService.add({
            severity: 'error',
            summary: 'Error',
            detail: response.message
          });
        }
      },
      error: (error) => {
        console.error('Error adding playlist to queue:', error);
        this.messageService.add({
          severity: 'error',
          summary: 'Error',
          detail: 'Failed to add playlist to queue'
        });
      }
    });
  }

  editPlaylistDetails(): void {
    if (!this.selectedPlaylist) return;
    // Show the edit playlist dialog instead of navigating
    this.showEditPlaylistDialog = true;
  }

  // Handle playlist updated event from the dialog
  handlePlaylistUpdated(updatedPlaylist: PlaylistDto): void {
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
        this.playlistService.deletePlaylist(this.selectedPlaylist!.id).subscribe({
          next: (response) => {
            if (response.data) {
              this.messageService.add({
                severity: 'success',
                summary: 'Deleted',
                detail: `"${this.selectedPlaylist?.name}" has been deleted`
              });
            } else {
              this.messageService.add({
                severity: 'error',
                summary: 'Error',
                detail: response.message
              });
            }
          },
          error: (error) => {
            console.error('Error deleting playlist:', error);
            this.messageService.add({
              severity: 'error',
              summary: 'Error',
              detail: 'Failed to delete playlist'
            });
          }
        });
      }
    });
  }

  ngOnDestroy(): void {
    // Clean up subscriptions
    this.subscription.unsubscribe();
  }
}
