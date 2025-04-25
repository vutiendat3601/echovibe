import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AudioService, Track } from '../../service/audio.service';
import { OfflineAudioService } from '../../service/offline-audio.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-offline-library',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './offline-library.component.html',
  styleUrls: ['./offline-library.component.scss']
})
export class OfflineLibraryComponent implements OnInit, OnDestroy {
  offlineTracks: Track[] = [];
  searchTerm: string = '';
  filteredTracks: Track[] = [];
  sortOption: string = 'dateAdded';
  isLoading: boolean = true;

  private subscriptions: Subscription[] = [];

  constructor(
    private audioService: AudioService,
    private offlineAudioService: OfflineAudioService
  ) { }

  ngOnInit(): void {
    this.subscriptions.push(
      this.offlineAudioService.offlineTracks$.subscribe(tracks => {
        this.offlineTracks = tracks;
        this.filterAndSortTracks();
        this.isLoading = false;
      })
    );
  }

  handlePlayTrack(track: Track): void {
    this.audioService.playOfflineTrack(track).catch(error => {
      console.error('Error playing offline track:', error);
      // Handle playback error
      alert('Error playing offline track. The file might be unavailable.');
    });
  }

  async handleRemoveTrack(event: Event, track: Track): Promise<void> {
    event.stopPropagation();
    if (confirm(`Remove "${track.name}" from your offline library?`)) {
      await this.offlineAudioService.removeTrackFromOffline(track.id);
    }
  }

  handleOnSearchChange(): void {
    this.filterAndSortTracks();
  }

  handleOnSortChange(): void {
    this.filterAndSortTracks();
  }

  private filterAndSortTracks(): void {
    // Filter tracks based on search term
    this.filteredTracks = this.offlineTracks.filter(track => {
      if (!this.searchTerm) return true;

      const searchTermLower = this.searchTerm.toLowerCase();
      return track.name.toLowerCase().includes(searchTermLower) ||
             track.artist.toLowerCase().includes(searchTermLower);
    });

    // Sort tracks based on selected option
    this.filteredTracks.sort((a, b) => {
      switch (this.sortOption) {
        case 'dateAdded':
          return (b.dateAdded || 0) - (a.dateAdded || 0);
        case 'name':
          return a.name.localeCompare(b.name);
        case 'artist':
          return a.artist.localeCompare(b.artist);
        default:
          return 0;
      }
    });
  }

  ngOnDestroy(): void {
    this.subscriptions.forEach(sub => sub.unsubscribe());
  }
}
