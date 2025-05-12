import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { environment } from '../../environment/environment';
import { ResponseDto } from '../dto/response-dto';
import { UserUsageDto } from './../dto/user-dto';
import { PlaylistService } from './playlist.service';
import { TrackService } from './track.service';
import { ArtistService } from './artist.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private retrievedUserUsage: UserUsageDto | null = null;
  private userUsageSubject: Subject<UserUsageDto> = new Subject();

  constructor(
    private readonly playlistService: PlaylistService,
    private readonly artistService: ArtistService,
    private readonly trackService: TrackService,
    private readonly http: HttpClient
  ) {
    this.refresh();
    this.listenDataChange();
  }

  refresh(): void {
    if (this.retrievedUserUsage) {
      this.userUsageSubject.next(this.retrievedUserUsage);
      return;
    }
    this.getUserUsageData().subscribe((respDto) => {
      this.retrievedUserUsage = respDto.data;
      this.userUsageSubject.next(this.retrievedUserUsage);
    });
  }

  get userUsageData(): Observable<UserUsageDto> {
    return this.userUsageSubject.asObservable();
  }

  private listenDataChange() {
    this.playlistService.createdPlaylistId.subscribe((playlistId) => {
      console.log('createdPlaylistId', playlistId);
      if (this.retrievedUserUsage && playlistId) {
        this.retrievedUserUsage.createdPlaylistIds.unshift(playlistId);
        this.refresh();
      }
    });

    this.artistService.likedArtistId.subscribe((artistId) => {
      if (this.retrievedUserUsage) {
        this.retrievedUserUsage.likedArtistIds.unshift(artistId);
        this.refresh();
      }
    });

    this.artistService.unlikedArtistId.subscribe((artistId) => {
      if (this.retrievedUserUsage) {
        this.retrievedUserUsage.likedArtistIds = this.retrievedUserUsage.likedArtistIds.filter((ai) => ai != artistId);
        this.refresh();
      }
    });

    this.trackService.likedTrackId.subscribe((trackId) => {
      if (this.retrievedUserUsage) {
        this.retrievedUserUsage.likedTrackIds.unshift(trackId);
        this.refresh();
      }
    });

    this.trackService.unlikedTrackId.subscribe((trackId) => {
      if (this.retrievedUserUsage) {
        this.retrievedUserUsage.likedTrackIds = this.retrievedUserUsage.likedTrackIds.filter((ti) => ti != trackId);
        this.refresh();
      }
    });
  }

  private getUserUsageData(): Observable<ResponseDto<UserUsageDto>> {
    return this.http.get<ResponseDto<UserUsageDto>>(`${environment.activityBaseUrl}/v1/me/usage-data`);
  }
}
