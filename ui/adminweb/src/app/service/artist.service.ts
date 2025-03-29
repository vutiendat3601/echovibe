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
  private readonly artistCreatedSubject = new BehaviorSubject<string | null>(null);
  private readonly artistUpdatedSubject = new BehaviorSubject<string | null>(null);
  private readonly artistReleasedSubject = new BehaviorSubject<string | null>(null);
  private readonly artistDeletedSubject = new BehaviorSubject<string | null>(null);

  constructor(private readonly http: HttpClient) {}

  get artistCreatedEvent(): Observable<string | null> {
    return this.artistCreatedSubject;
  }

  get artistUpdatedEvent(): Observable<string | null> {
    return this.artistUpdatedSubject;
  }

  get artistReleasedEvent(): Observable<string | null> {
    return this.artistReleasedSubject;
  }

  get artistDeletedEvent(): Observable<string | null> {
    return this.artistDeletedSubject;
  }

  bulkCreateArtist(bulkCreateArtistDtos: BulkDto<CreateArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-create`, bulkCreateArtistDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items
            .filter(({ id, isSuccessful }) => id && isSuccessful)
            .forEach(({ id }) => this.artistCreatedSubject.next(id))
        )
      );
  }

  bulkUpdateArtist(bulkUpdateArtistDtos: BulkDto<UpdateArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-update`, bulkUpdateArtistDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items
            .filter(({ id, isSuccessful }) => id && isSuccessful)
            .forEach(({ id }) => this.artistUpdatedSubject.next(id))
        )
      );
  }

  bulkDeleteArtist(bulkDeleteArtistDtos: BulkDto<DeleteArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-delete`, bulkDeleteArtistDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items
            .filter(({ id, isSuccessful }) => id && isSuccessful)
            .forEach(({ id }) => this.artistDeletedSubject.next(id))
        )
      );
  }

  bulkReleaseArtist(bulkReleaseArtistDtos: BulkDto<ReleaseArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-release`, bulkReleaseArtistDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items
            .filter(({ id, isSuccessful }) => id && isSuccessful)
            .forEach(({ id }) => this.artistReleasedSubject.next(id))
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

  getMockArtists(): Observable<ResponseDto<[ArtistDto | null]>> {
    return this.getArtistByRefCodes(
      [
        'spt_5dfZ5uSmzR7VQK0udbAVpf',
        'spt_2Bwp23pD4UVsSkchHDZw4F',
        'spt_0r63ReVRjxrS4ATbLrdcrL',
        'spt_1CWwyDPjCowRTO4p6A7r6g',
        'spt_5HZtdKfC4xU0wvhEyYDWiY',
        'spt_57g2v7gJZepcwsuwssIfZs',
        'spt_2aQnC3DbZB9GbauvhAw7ve',
        'spt_1L1VfizWn4DkFt602yD80U',
        'spt_3y0Tmt0epaxAHy6L89dGGC',
        'spt_0l3YAI1xmZKCZBzduST5ft',
        'spt_5lAfakPZgxFKgiJD6xAF1G',
        'spt_3diftVOq7aEIebXKkC34oR',
        'spt_2NRcG7E1j2sSi8vnUzCcpi'
      ],
      true,
      true
    );
  }
}
