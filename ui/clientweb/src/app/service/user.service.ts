import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { identity, Observable, Subject } from 'rxjs';
import { environment } from '../../environment/environment';
import { ResponseDto } from '../dto/response-dto';
import { UserStatsDto } from './../dto/user-dto';
import { PlaylistService } from './playlist.service';
import { TrackService } from './track.service';
import { ArtistService } from './artist.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private retrievedUserStats: UserStatsDto | null = null;
  private userStatsSubject: Subject<UserStatsDto> = new Subject();

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
    if (this.retrievedUserStats) {
      this.userStatsSubject.next(this.retrievedUserStats);
      return;
    }
    this.getUserStats().subscribe((respDto) => {
      this.retrievedUserStats = respDto.data;
      this.userStatsSubject.next(this.retrievedUserStats);
    });
  }

  get userStats(): Observable<UserStatsDto> {
    return this.userStatsSubject.asObservable();
  }

  private listenDataChange() {
    this.playlistService.createdPlaylistId.subscribe((_playlistId) => {});

    this.artistService.likedArtistId.subscribe((artistId) => {
      if (this.retrievedUserStats) {
        this.retrievedUserStats.likedArtistIds.unshift(artistId);
        this.refresh();
      }
    });

    this.artistService.unlikedArtistId.subscribe((artistId) => {
      if (this.retrievedUserStats) {
        this.retrievedUserStats.likedArtistIds = this.retrievedUserStats.likedArtistIds.filter((ai) => ai != artistId);
        this.refresh();
      }
    });

    this.trackService.likedTrackId.subscribe((trackId) => {
      if (this.retrievedUserStats) {
        this.retrievedUserStats.likedTrackIds.unshift(trackId);
        this.refresh();
      }
    });

    this.trackService.unlikedTrackId.subscribe((trackId) => {
      if (this.retrievedUserStats) {
        this.retrievedUserStats.likedTrackIds = this.retrievedUserStats.likedTrackIds.filter((ti) => ti != trackId);
        this.refresh();
      }
    });
  }

  private getUserStats(): Observable<ResponseDto<UserStatsDto>> {
    return this.http.get<ResponseDto<UserStatsDto>>(`${environment.activityBaseUrl}/v1/me/stats`);
  }
}
