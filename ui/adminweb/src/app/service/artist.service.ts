import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, map, Observable, tap } from 'rxjs';
import { environment } from '../../environment/environment';
import { ArtistDto, CreateArtistDto, DeleteArtistDto, ReleaseArtistDto, UpdateArtistDto } from '../dto/artist-dto';
import { BulkDto } from '../dto/bulk-dto';
import { BulkResult } from '../model/bulk-result';
import { ResponseDto } from './../dto/response-dto';

@Injectable({
  providedIn: 'root'
})
export class ArtistService {
  private readonly changedArtistsSubject = new BehaviorSubject<ArtistDto[]>([]);
  private readonly changedArtistIds: Map<string, Date> = new Map();

  constructor(private readonly http: HttpClient) {
    this.refreshDataInterval(3_000);
  }

  get changedArtistsEvent(): Observable<ArtistDto[]> {
    return this.changedArtistsSubject;
  }

  bulkCreateArtist(bulkCreateArtistDtos: BulkDto<CreateArtistDto>): Observable<ResponseDto<BulkResult>> {
    const actionTime = new Date();
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-create`, bulkCreateArtistDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items.forEach(
            ({ id, isSuccessful }) => id && isSuccessful && this.changedArtistIds.set(id, actionTime)
          )
        )
      );
  }

  bulkUpdateArtist(bulkUpdateArtistDtos: BulkDto<UpdateArtistDto>): Observable<ResponseDto<BulkResult>> {
    const actionTime = new Date();
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-update`, bulkUpdateArtistDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items.forEach(
            ({ id, isSuccessful }) => id && isSuccessful && this.changedArtistIds.set(id, actionTime)
          )
        )
      );
  }

  bulkDeleteArtist(bulkDeleteArtistDtos: BulkDto<DeleteArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http.post<ResponseDto<BulkResult>>(
      `${environment.artistCommandBaseUrl}/bulk-delete`,
      bulkDeleteArtistDtos
    );
  }

  bulkReleaseArtist(bulkReleaseArtistDtos: BulkDto<ReleaseArtistDto>): Observable<ResponseDto<BulkResult>> {
    const actionTime = new Date();
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-release`, bulkReleaseArtistDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items.forEach(
            ({ id, isSuccessful }) => id && isSuccessful && this.changedArtistIds.set(id, actionTime)
          )
        )
      );
  }

  getArtistByIds(
    ids: string[],
    loadImages: boolean = false,
    loadRevisions: boolean = false
  ): Observable<ResponseDto<[ArtistDto | null]>> {
    return this.http.get<ResponseDto<[ArtistDto | null]>>(
      `${environment.artistQueryBaseUrl}/byId?loadImages=${loadImages}&loadRevisions=${loadRevisions}&ids=${ids.join(',')}`
    );
  }

  getArtistByRefCodes(
    refCodes: string[],
    loadImages: boolean = false,
    loadRevisions: boolean = false
  ): Observable<ResponseDto<[ArtistDto | null]>> {
    return this.http.get<ResponseDto<[ArtistDto | null]>>(
      `${environment.artistQueryBaseUrl}/byRefCode?loadImages=${loadImages}&loadRevisions=${loadRevisions}&refCodes=${refCodes.join(',')}`
    );
  }

  // ### Mock datas, need to remove when finish ################################

  getAllArtists(loadImages: boolean = false, loadRevisions: boolean = false): Observable<ResponseDto<[ArtistDto]>> {
    return this.http.get<ResponseDto<[ArtistDto]>>(
      `${environment.artistQueryBaseUrl}/all?loadImages=${loadImages}&loadRevisions=${loadRevisions}`
    );
  }

  private refreshDataInterval(intervalMs: number = 3_000): void {
    setInterval(() => {
      if (this.changedArtistIds.size) {
        if (!environment.production) {
          console.log('Changed Artists: ', this.changedArtistIds);
        }

        this.getArtistByIds([...this.changedArtistIds.keys()], true, true).subscribe((respDto) => {
          const artists = respDto.data.filter((artist) => artist !== null);
          if (artists.length) {
            artists.forEach(
              ({ id, updatedAt }) =>
                (this.changedArtistIds.get(id) || new Date()) < new Date(updatedAt) && this.changedArtistIds.delete(id)
            );
            this.changedArtistsSubject.next(artists);
          }
        });
      }
    }, intervalMs);
  }
}
