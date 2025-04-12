import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, tap } from 'rxjs';
import { environment } from '../../environment/environment';
import { BulkDto } from '../dto/bulk-dto';
import { ResponseDto } from '../dto/response-dto';
import { CreateTrackDto, DeleteTrackDto, ReleaseTrackDto, TrackDto, UpdateTrackDto } from '../dto/track-dto';
import { BulkResult } from '../model/bulk-result';

@Injectable({
  providedIn: 'root'
})
export class TrackService {
  private readonly trackCreatedSubject = new BehaviorSubject<string | null>(null);
  private readonly trackUpdatedSubject = new BehaviorSubject<string | null>(null);
  private readonly trackReleasedSubject = new BehaviorSubject<string | null>(null);
  private readonly trackDeletedSubject = new BehaviorSubject<string | null>(null);

  constructor(private readonly http: HttpClient) {}

  get trackCreatedEvent(): Observable<string | null> {
    return this.trackCreatedSubject;
  }

  get trackUpdatedEvent(): Observable<string | null> {
    return this.trackUpdatedSubject;
  }

  get trackReleasedEvent(): Observable<string | null> {
    return this.trackReleasedSubject;
  }

  get trackDeletedEvent(): Observable<string | null> {
    return this.trackDeletedSubject;
  }

  bulkCreateTrack(bulkCreateTrackDtos: BulkDto<CreateTrackDto>): Observable<ResponseDto<BulkResult>> {
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.trackCommandBaseUrl}/bulk-create`, bulkCreateTrackDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items
            .filter(({ id, isSuccessful }) => id && isSuccessful)
            .forEach(({ id }) => this.trackCreatedSubject.next(id))
        )
      );
  }

  bulkUpdateTrack(bulkUpdateTrackDtos: BulkDto<UpdateTrackDto>): Observable<ResponseDto<BulkResult>> {
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.trackCommandBaseUrl}/bulk-update`, bulkUpdateTrackDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items
            .filter(({ id, isSuccessful }) => id && isSuccessful)
            .forEach(({ id }) => this.trackUpdatedSubject.next(id))
        )
      );
  }

  bulkDeleteTrack(bulkDeleteTrackDtos: BulkDto<DeleteTrackDto>): Observable<ResponseDto<BulkResult>> {
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.trackCommandBaseUrl}/bulk-delete`, bulkDeleteTrackDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items
            .filter(({ id, isSuccessful }) => id && isSuccessful)
            .forEach(({ id }) => this.trackDeletedSubject.next(id))
        )
      );
  }

  bulkReleaseTrack(bulkReleaseTrackDtos: BulkDto<ReleaseTrackDto>): Observable<ResponseDto<BulkResult>> {
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.trackCommandBaseUrl}/bulk-release`, bulkReleaseTrackDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items
            .filter(({ id, isSuccessful }) => id && isSuccessful)
            .forEach(({ id }) => this.trackReleasedSubject.next(id))
        )
      );
  }

  getTrackByIds(
    ids: string[],
    loadImages: boolean = false,
    loadRevisions: boolean = false
  ): Observable<ResponseDto<[TrackDto | null]>> {
    return this.http.get<ResponseDto<[TrackDto | null]>>(
      `${environment.trackQueryBaseUrl}/byId?loadImages=${loadImages}&loadRevisions=${loadRevisions}&ids=${ids.join(',')}`
    );
  }

  getTrackByRefCodes(
    refCodes: string[],
    loadImages: boolean = false,
    loadRevisions: boolean = false
  ): Observable<ResponseDto<[TrackDto | null]>> {
    return this.http.get<ResponseDto<[TrackDto | null]>>(
      `${environment.trackQueryBaseUrl}/byRefCode?loadImages=${loadImages}&loadRevisions=${loadRevisions}&refCodes=${refCodes.join(',')}`
    );
  }

  // ### Mock datas, need to remove when finish ################################

  getAllTracks(loadImages: boolean = false, loadRevisions: boolean = false): Observable<ResponseDto<[TrackDto]>> {
    return this.http.get<ResponseDto<[TrackDto]>>(
      `${environment.trackQueryBaseUrl}/all?loadImages=${loadImages}&loadRevisions=${loadRevisions}`
    );
  }
}
