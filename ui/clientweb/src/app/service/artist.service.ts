import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { environment } from '../../environment/environment';
import { ArtistDetailDto } from '../dto/artist-dto';
import { ResponseDto } from './../dto/response-dto';
import { ActivityService } from './activity.service';
import { ActionType } from '../constant/action-type';

@Injectable({
  providedIn: 'root'
})
export class ArtistService {
  private likedArtistIdSubject: Subject<string> = new Subject();
  private unlikedArtistIdSubject: Subject<string> = new Subject();

  constructor(
    private readonly activityService: ActivityService,
    private readonly http: HttpClient
  ) {}

  getArtistById(id: string): Observable<ResponseDto<ArtistDetailDto | null>> {
    return this.http.get<ResponseDto<ArtistDetailDto | null>>(`${environment.productBaseUrl}/v1/artists/${id}`);
  }

  getArtistByIds(ids: string[]): Observable<ResponseDto<[ArtistDetailDto | null]>> {
    return this.http.get<ResponseDto<[ArtistDetailDto | null]>>(
      `${environment.productBaseUrl}/v1/artists?ids=${ids.join(',')}`
    );
  }

  likeArtist(id: string): void {
    this.likedArtistIdSubject.next(id);
    this.activityService.sendMessage({
      aggregateId: id,
      sessionId: null,
      type: ActionType.LIKE_ARTIST,
      dataJson: null
    });
  }

  unlikeArtist(id: string): void {
    this.unlikedArtistIdSubject.next(id);
    this.activityService.sendMessage({
      aggregateId: id,
      sessionId: null,
      type: ActionType.UNLIKE_ARTIST,
      dataJson: null
    });
  }

  get likedArtistId(): Observable<string> {
    return this.likedArtistIdSubject.asObservable();
  }

  get unlikedArtistId(): Observable<string> {
    return this.unlikedArtistIdSubject.asObservable();
  }
}
