import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, tap } from 'rxjs';
import { environment } from '../../environment/environment';
import { BulkDto } from '../dto/bulk-dto';
import { ResponseDto } from '../dto/response-dto';
import {
  CreateTrackDto,
  DeleteTrackDto,
  MapTrackAudioDto,
  ReleaseTrackDto,
  TrackDto,
  UpdateTrackDto
} from '../dto/track-dto';
import { BulkResult } from '../model/bulk-result';

@Injectable({
  providedIn: 'root'
})
export class TrackService {
  private readonly changedTracksSubject = new BehaviorSubject<TrackDto[]>([]);
  private readonly changedTrackIds: Map<string, Date> = new Map();
  constructor(private readonly http: HttpClient) {
    this.refreshDataInterval(3_000);
  }

  get changedTracksEvent(): Observable<TrackDto[]> {
    return this.changedTracksSubject;
  }

  bulkCreateTrack(bulkCreateTrackDtos: BulkDto<CreateTrackDto>): Observable<ResponseDto<BulkResult>> {
    const actionTime = new Date();
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.trackCommandBaseUrl}/bulk-create`, bulkCreateTrackDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items.filter(
            ({ id, isSuccessful }) => id && isSuccessful && this.changedTrackIds.set(id, actionTime)
          )
        )
      );
  }

  bulkUpdateTrack(bulkUpdateTrackDtos: BulkDto<UpdateTrackDto>): Observable<ResponseDto<BulkResult>> {
    const actionTime = new Date();
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.trackCommandBaseUrl}/bulk-update`, bulkUpdateTrackDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items.filter(
            ({ id, isSuccessful }) => id && isSuccessful && this.changedTrackIds.set(id, actionTime)
          )
        )
      );
  }

  bulkDeleteTrack(bulkDeleteTrackDtos: BulkDto<DeleteTrackDto>): Observable<ResponseDto<BulkResult>> {
    const actionTime = new Date();
    return this.http.post<ResponseDto<BulkResult>>(
      `${environment.trackCommandBaseUrl}/bulk-delete`,
      bulkDeleteTrackDtos
    );
  }

  bulkReleaseTrack(bulkReleaseTrackDtos: BulkDto<ReleaseTrackDto>): Observable<ResponseDto<BulkResult>> {
    const actionTime = new Date();
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.trackCommandBaseUrl}/bulk-release`, bulkReleaseTrackDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items.forEach(
            ({ id, isSuccessful }) => id && isSuccessful && this.changedTrackIds.set(id, actionTime)
          )
        )
      );
  }

  bulkMapTrackAdio(bulkMapTrackAudioDtos: BulkDto<MapTrackAudioDto>) {
    const actionTime = new Date();
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.trackCommandBaseUrl}/bulk-map-audio`, bulkMapTrackAudioDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items.forEach(
            ({ id, isSuccessful }) => id && isSuccessful && this.changedTrackIds.set(id, actionTime)
          )
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

  private refreshDataInterval(intervalMs: number = 3_000): void {
    setInterval(() => {
      if (this.changedTrackIds.size) {
        if (!environment.production) {
          console.log('Changed Tracks: ', this.changedTrackIds);
        }

        this.getTrackByIds([...this.changedTrackIds.keys()], true, true).subscribe((respDto) => {
          const tracks: TrackDto[] = respDto.data.filter((track) => track !== null);
          if (tracks.length) {
            tracks.forEach(
              ({ id, updatedAt }) =>
                (this.changedTrackIds.get(id) || new Date()) < new Date(updatedAt) && this.changedTrackIds.delete(id)
            );
            this.changedTracksSubject.next(tracks);
          }
        });
      }
    }, intervalMs);
  }
}
