import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AudioService, EnhancedTrackDto } from '../../service/audio.service';
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
  offlineTracks: EnhancedTrackDto[] = [];
  searchTerm: string = '';
  filteredTracks: EnhancedTrackDto[] = [];
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

  handlePlayTrack(track: EnhancedTrackDto): void {
    this.audioService.playOfflineTrack(track).catch(error => {
      console.error('Error playing offline track:', error);
      // Handle playback error
      alert('Error playing offline track. The file might be unavailable.');
    });
  }

  async handleRemoveTrack(event: Event, track: EnhancedTrackDto): Promise<void> {
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

  // Get artist name from EnhancedTrackDto
  getArtistName(track: EnhancedTrackDto): string {
    if (!track.artists || track.artists.length === 0) return 'Unknown Artist';

    const mainArtist = track.artists.find(artist => artist.isMainArtist);
    if (mainArtist) {
      return mainArtist.name;
    }
    return track.artists.map(artist => artist.name).join(', ');
  }

  private filterAndSortTracks(): void {
    // Filter tracks based on search term
    this.filteredTracks = this.offlineTracks.filter(track => {
      if (!this.searchTerm) return true;

      const searchTermLower = this.searchTerm.toLowerCase();
      const artistName = this.getArtistName(track);

      return track.name.toLowerCase().includes(searchTermLower) ||
             artistName.toLowerCase().includes(searchTermLower);
    });

    // Sort tracks based on selected option
    this.filteredTracks.sort((a, b) => {
      switch (this.sortOption) {
        case 'dateAdded':
          return (b.dateAdded || 0) - (a.dateAdded || 0);
        case 'name':
          return a.name.localeCompare(b.name);
        case 'artist':
          return this.getArtistName(a).localeCompare(this.getArtistName(b));
        default:
          return 0;
      }
    });
  }

  ngOnDestroy(): void {
    this.subscriptions.forEach(sub => sub.unsubscribe());
  }
}
