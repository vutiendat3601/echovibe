import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, map, Observable, tap } from 'rxjs';
import { environment } from '../../environment/environment';
import { ArtistDto, CreateArtistDto, DeleteArtistDto } from '../dto/artist-dto';
import { BulkDto } from '../dto/bulk-dto';
import { BulkResult } from '../model/bulk-result';
import { ResponseDto } from './../dto/response-dto';

@Injectable({
  providedIn: 'root'
})
export class ArtistService {
  private readonly artistCreatedIdSubject = new BehaviorSubject<string | null>(null);

  constructor(private readonly http: HttpClient) {}

  artistCreatedId(): Observable<string | null> {
    return this.artistCreatedIdSubject;
  }

  bulkCreateArtist(bulkCreateArtistDtos: BulkDto<CreateArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http
      .post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-create`, bulkCreateArtistDtos)
      .pipe(
        tap((respDto) =>
          respDto.data.items.filter(({ id }) => id).forEach(({ id }) => this.artistCreatedIdSubject.next(id))
        )
      );
  }

  bulkDeleteArtist(bulkDeleteArtistDtos: BulkDto<DeleteArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http.post<ResponseDto<BulkResult>>(
      `${environment.artistCommandBaseUrl}/bulk-delete`,
      bulkDeleteArtistDtos
    );
  }

  getArtistByIds(
    ids: string[],
    loadImages: boolean = false,
    loadRevisions: boolean = false
  ): Observable<ResponseDto<[ArtistDto | null]>> {
    return this.http.get<ResponseDto<[ArtistDto | null]>>(
      `${environment.artistQueryBaseUrl}/byId?loadImages=true&loadRevisions=true&ids=${ids.join(',')}`
    );
  }

  getArtistByRefCodes(
    refCodes: string[],
    loadImages: boolean = false,
    loadRevisions: boolean = false
  ): Observable<ResponseDto<[ArtistDto | null]>> {
    return this.http.get<ResponseDto<[ArtistDto | null]>>(
      `${environment.artistQueryBaseUrl}/byRefCode?loadImages=true&loadRevisions=true&refCodes=${refCodes.join(',')}`
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
