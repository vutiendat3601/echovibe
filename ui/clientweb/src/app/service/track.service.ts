import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environment/environment';
import { TrackDto } from '../dto/track-dto';
import { ResponseDto } from '../dto/response-dto';

@Injectable({
  providedIn: 'root'
})
export class TrackService {
  constructor(private readonly http: HttpClient) {}

  getTrackById(id: string): Observable<ResponseDto<TrackDto | null>> {
    return this.http.get<ResponseDto<TrackDto | null>>(`${environment.productBaseUrl}/v1/tracks/${id}`);
  }
}
