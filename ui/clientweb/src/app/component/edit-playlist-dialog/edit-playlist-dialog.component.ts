import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { InputTextModule } from 'primeng/inputtext';
import { TextareaModule } from 'primeng/textarea'; // Fix: Correct module name
import { PlaylistDetailDto } from '../../dto/playlist-dto';
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
    // if (this.playlist) {
    //   this.playlistName = this.playlist.name;
    //   this.playlistDescription = this.playlist.description || '';
    //   this.imageUrl = this.playlist.coverImageUrl || '';
    // }
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
    // if (!this.playlist) return;
    // this.isSubmitting = true;
    // In a real application, you would handle file upload and then update the playlist
    // For now, we'll just use the image URL from the selected file (preview)
    // const coverImageUrl = this.imageUrl;
    // this.playlistService.updatePlaylist(
    //   this.playlist.id,
    //   this.playlistName,
    //   this.playlistDescription,
    //   coverImageUrl
    // ).subscribe({
    //   next: (response) => {
    //     if (response.data) {
    //       this.messageService.add({
    //         severity: 'success',
    //         summary: 'Success',
    //         detail: 'Playlist details updated successfully'
    //       });
    //       this.playlistUpdated.emit(response.data);
    //       this.onHide();
    //     } else {
    //       this.messageService.add({
    //         severity: 'error',
    //         summary: 'Error',
    //         detail: response.message
    //       });
    //     }
    //     this.isSubmitting = false;
    //   },
    //   error: (error) => {
    //     console.error('Error updating playlist:', error);
    //     this.messageService.add({
    //       severity: 'error',
    //       summary: 'Error',
    //       detail: 'Failed to update playlist details'
    //     });
    //     this.isSubmitting = false;
    //   }
    // });
  }
}
