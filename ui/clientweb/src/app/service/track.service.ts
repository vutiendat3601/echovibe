import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { environment } from '../../environment/environment';
import { TrackDetailDto } from '../dto/track-dto';
import { ResponseDto } from '../dto/response-dto';
import { ActivityService } from './activity.service';
import { ActionType } from '../constant/action-type';

@Injectable({
  providedIn: 'root'
})
export class TrackService {
  private likedTrackIdSubject: Subject<string> = new Subject();
  private unlikedTrackIdSubject: Subject<string> = new Subject();

  constructor(
    private readonly activityService: ActivityService,
    private readonly http: HttpClient
  ) {}

  getTrackById(id: string): Observable<ResponseDto<TrackDetailDto | null>> {
    return this.http.get<ResponseDto<TrackDetailDto | null>>(`${environment.productBaseUrl}/v1/tracks/${id}`);
  }

  getTrackByIds(ids: string[]): Observable<ResponseDto<[TrackDetailDto | null]>> {
    return this.http.get<ResponseDto<[TrackDetailDto | null]>>(
      `${environment.productBaseUrl}/v1/tracks?ids=${ids.join(',')}`
    );
  }

  likeTrack(id: string): void {
    this.likedTrackIdSubject.next(id);
    this.activityService.sendMessage({
      aggregateId: id,
      sessionId: null,
      type: ActionType.LIKE_TRACK,
      dataJson: null
    });
  }

  unlikeTrack(id: string): void {
    this.unlikedTrackIdSubject.next(id);
    this.activityService.sendMessage({
      aggregateId: id,
      sessionId: null,
      type: ActionType.UNLIKE_TRACK,
      dataJson: null
    });
  }

  get likedTrackId(): Observable<string> {
    return this.likedTrackIdSubject.asObservable();
  }

  get unlikedTrackId(): Observable<string> {
    return this.unlikedTrackIdSubject.asObservable();
  }
}
