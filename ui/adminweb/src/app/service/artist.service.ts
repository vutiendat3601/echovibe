import { Injectable } from '@angular/core';
import { environment } from '../../environment/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ArtistDto, CreateArtistDto, DeleteArtistDto } from '../dto/artist-dto';
import { ResponseDto } from '../dto/response-dto';
import { BulkResult } from '../model/bulk-result';
import { BulkDto } from '../dto/bulk-dto';

@Injectable({
  providedIn: 'root'
})
export class ArtistService {
  constructor(private readonly http: HttpClient) {}

  bulkCreateArtist(bulkCreateArtistDtos: BulkDto<CreateArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http.post<ResponseDto<BulkResult>>(
      `${environment.artistCommandBaseUrl}/bulk-create`,
      bulkCreateArtistDtos
    );
  }

  bulkDeleteArtist(bulkDeleteArtistDtos: BulkDto<DeleteArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http.post<ResponseDto<BulkResult>>(
      `${environment.artistCommandBaseUrl}/bulk-delete`,
      bulkDeleteArtistDtos
    );
  }

  getArtistByIds(ids: string[]): Observable<ResponseDto<ArtistDto[]>> {
    return this.http.get<ResponseDto<ArtistDto[]>>(`${environment.artistQueryBaseUrl}/byId?ids=${ids.join(',')}`);
  }

  getArtistByRefCodes(refCodes: string[]): Observable<ResponseDto<ArtistDto[]>> {
    return this.http.get<ResponseDto<ArtistDto[]>>(
      `${environment.artistQueryBaseUrl}/byRefCode?refCodes=${refCodes.join(',')}`
    );
  }

  // ### Mock datas, need to remove when finish ################################

  getMockArtists(): Observable<ResponseDto<ArtistDto[]>> {
    return this.getArtistByRefCodes([
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
    ]);
  }
}
