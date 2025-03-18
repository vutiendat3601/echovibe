import { Injectable } from '@angular/core';
import { environment } from '../../environment/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CreateArtistDto } from '../dto/artist-dto';
import { ResponseDto } from '../dto/response-dto';
import { BulkResult } from '../model/bulk-result';
import { BulkDto } from '../dto/bulk-dto';

@Injectable({
  providedIn: 'root'
})
export class ArtistService {
  constructor(private readonly http: HttpClient) {}

  createArtist(bulkCreateArtistDtos: BulkDto<CreateArtistDto>): Observable<ResponseDto<BulkResult>> {
    return this.http.post<ResponseDto<BulkResult>>(`${environment.artistCommandBaseUrl}/bulk-create`, bulkCreateArtistDtos);
  }
}
