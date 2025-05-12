import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { InputTextModule } from 'primeng/inputtext';
import { TextareaModule } from 'primeng/textarea'; // Fix: Correct module name
import { PlaylistDetailDto, UpdatePlaylistDto } from '../../dto/playlist-dto';
import { PlaylistService } from '../../service/playlist.service';
import { MessageService } from 'primeng/api';
import { ToastModule } from 'primeng/toast';

@Component({
  selector: 'app-edit-playlist-dialog',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    DialogModule,
    ButtonModule,
    InputTextModule,
    TextareaModule, // Fix: Use correct module name
    ToastModule
  ],
  templateUrl: './edit-playlist-dialog.component.html',
  styleUrls: ['./edit-playlist-dialog.component.scss'],
  providers: [MessageService]
})
export class EditPlaylistDialogComponent implements OnInit {
  @Input() visible: boolean = false;
  @Input() playlist: PlaylistDetailDto | null = null;
  @Output() visibleChange = new EventEmitter<boolean>();
  @Output() playlistUpdated = new EventEmitter<PlaylistDetailDto>();

  // Form fields
  playlistName: string = '';
  playlistDescription: string = '';
  imageUrl: string = '';
  selectedFile: File | null = null;
  isSubmitting: boolean = false;

  constructor(
    private playlistService: PlaylistService,
    private messageService: MessageService
  ) {}

  ngOnInit(): void {
    this.resetForm();
  }

  ngOnChanges(): void {
    // Reset form when playlist changes
    this.resetForm();
  }

  resetForm(): void {
    if (this.playlist) {
      this.playlistName = this.playlist.name;
      // Note: Description is not in the PlaylistDetailDto so we keep it empty
      this.playlistDescription = '';

      // First check if the playlist has its own thumbnail URL
      if (typeof this.playlist.thumbnailUrl === 'string' && this.playlist.thumbnailUrl) {
        this.imageUrl = this.playlist.thumbnailUrl;
      }
      // If not, fall back to the first track's thumbnail if available
      else if (this.playlist.tracks && this.playlist.tracks.length > 0 && this.playlist.tracks[0].thumbnailUrl) {
        this.imageUrl = this.playlist.tracks[0].thumbnailUrl;
      } else {
        this.imageUrl = '';
      }
    }
  }

  onHide(): void {
    this.visible = false;
    this.visibleChange.emit(false);
  }

  onFileSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      this.selectedFile = input.files[0];

      // Preview the selected image
      const reader = new FileReader();
      reader.onload = (e) => {
        this.imageUrl = e.target?.result as string;
      };
      reader.readAsDataURL(this.selectedFile);
    }
  }

  triggerFileInput(): void {
    document.getElementById('fileInput')?.click();
  }

  saveChanges(): void {
    if (!this.playlist) {
      this.messageService.add({
        severity: 'error',
        summary: 'Error',
        detail: 'No playlist to update'
      });
      return;
    }

    if (!this.playlistName.trim()) {
      this.messageService.add({
        severity: 'error',
        summary: 'Error',
        detail: 'Playlist name cannot be empty'
      });
      return;
    }

    this.isSubmitting = true;

    // Create a backup of the current playlist for optimistic UI update
    const originalPlaylist = { ...this.playlist };

    // Create an updated playlist object
    // We'll create a modified playlist object that includes custom properties
    // We'll work around the type constraints by using type assertion
    const updatedPlaylist = {
      ...this.playlist,
      name: this.playlistName,
      // Add a custom property to pass the new thumbnail URL
      _newThumbnailUrl: this.selectedFile ? this.imageUrl :
                      (typeof this.playlist.thumbnailUrl === 'string' ? this.playlist.thumbnailUrl : null)
    } as PlaylistDetailDto;

    // Create the update DTO for sending to service
    const updatePlaylistDto: UpdatePlaylistDto = {
      id: this.playlist.id,
      name: this.playlistName,
      isPublic: this.playlist.isPublic,
      // Use the updated image URL if available, otherwise keep existing or null
      thumbnailUrl: this.selectedFile ? this.imageUrl :
                   (typeof this.playlist.thumbnailUrl === 'string' ? this.playlist.thumbnailUrl : null),
      // Keep the same tracks
      trackIds: this.playlist.tracks.map(track => track.id)
    };

    // Emit optimistic update immediately for responsive UI
    this.playlistUpdated.emit(updatedPlaylist);

    try {
      // Update playlist in the backend
      this.playlistService.updatePlaylist(updatePlaylistDto);

      // Show success message
      this.messageService.add({
        severity: 'success',
        summary: 'Success',
        detail: 'Playlist details updated successfully'
      });

      // Short delay before hiding to ensure toast is displayed
      setTimeout(() => {
        // Close dialog
        this.onHide();
      }, 100);
    } catch (error) {
      console.error('Error updating playlist:', error);

      // Show error message
      this.messageService.add({
        severity: 'error',
        summary: 'Error',
        detail: 'Failed to update playlist details'
      });

      // Emit original playlist to rollback changes
      this.playlistUpdated.emit(originalPlaylist);
    } finally {
      this.isSubmitting = false;
    }
  }
}
