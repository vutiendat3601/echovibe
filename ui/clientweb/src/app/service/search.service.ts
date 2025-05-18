import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { environment } from '../../environment/environment';
import { ActionType } from '../constant/action-type';
import { SearchDto } from '../dto/search-dto';
import { UserRecentSearchDto } from '../dto/user-dto';
import { SearchType } from '../model/search-type';
import { ResponseDto } from './../dto/response-dto';
import { ActivityService } from './activity.service';

@Injectable({
  providedIn: 'root'
})
export class SearchService {
  private recentSearchesSubject: Subject<UserRecentSearchDto[]> = new Subject();

  constructor(
    private readonly http: HttpClient,
    private readonly activityService: ActivityService
  ) {}

  search(
    keyword: string,
    page: number = 0,
    size: number = 100,
    types: SearchType[] = [SearchType.ARTIST, SearchType.TRACK, SearchType.PLAYLIST]
  ): Observable<ResponseDto<SearchDto>> {
    return this.http.get<ResponseDto<SearchDto>>(
      `${environment.productBaseUrl}/v1/search?keyword=${keyword}&page=${page}&size=${size}&types=${types.join(',')}`
    );
  }

  updateRecentSearches(recentSearches: UserRecentSearchDto[]): void {
    this.recentSearchesSubject.next(recentSearches);
    this.activityService.sendMessage({
      aggregateId: null,
      sessionId: null,
      type: ActionType.VIEWED_SEARCH_RESULT,
      dataJson: {
        recentSearches
      }
    });
  }

  get recentSearches() {
    return this.recentSearchesSubject.asObservable();
  }
}
