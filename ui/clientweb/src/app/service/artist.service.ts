import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environment/environment';
import { ArtistDto } from '../dto/artist-dto';
import { ResponseDto } from './../dto/response-dto';

@Injectable({
  providedIn: 'root'
})
export class ArtistService {
  constructor(private readonly http: HttpClient) {}

  getArtistById(id: string): Observable<ResponseDto<ArtistDto | null>> {
    return this.http.get<ResponseDto<ArtistDto | null>>(`${environment.productBaseUrl}/v1/artists/${id}`);
  }
}
