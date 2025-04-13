import { ResponseDto } from './../dto/response-dto';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environment/environment';
import { SearchDto } from '../dto/search-dto';
import { SearchType } from '../model/search-type';

@Injectable({
  providedIn: 'root'
})
export class SearchService {
  constructor(private readonly http: HttpClient) {}

  search(
    keyword: string,
    page: number = 0,
    size: number = 100,
    types: SearchType[] = [SearchType.ARTIST]
  ): Observable<ResponseDto<SearchDto>> {
    return this.http.get<ResponseDto<SearchDto>>(
      `${environment.productBaseUrl}/v1/search?keyword=${keyword}&page=${page}&size=${size}&types=${types.join(',')}`
    );
  }
}
