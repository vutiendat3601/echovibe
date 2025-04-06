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
        'spt_2NRcG7E1j2sSi8vnUzCcpi',
        'spt_6G1NZbNUXtjdhTKWRTpoBd',
        'spt_5ArlH2m6JTQYpCmFF6re7i',
        'spt_75Ki5hBCOpDtKGoFyTvLxP',
        'spt_0r63ReVRjxrS4ATbLrdcrL',
        'spt_2aQnC3DbZB9GbauvhAw7ve',
        'spt_1LEtM3AleYg1xabW6CRkpi',
        'spt_1CWwyDPjCowRTO4p6A7r6g',
        'spt_57g2v7gJZepcwsuwssIfZs',
        'spt_5HZtdKfC4xU0wvhEyYDWiY',
        'spt_4iFNiWhODcMZdmpNkxsTFp',
        'spt_2Fc5cGXai8xzLhGyltp4tT',
        'spt_3EPkqJFzEGSJWtGsu1Xwqt',
        'spt_3Tehj7YghQc7zH0I1faGc6',
        'spt_4grjJqg7iwQ8RKHs8d9Snh',
        'spt_4jQZaxfgwiUJFQagCyZNV4',
        'spt_40JnMfFlpwqBnWitkL96g4',
        'spt_4e5LAUvM35jleGg8gElTsP',
        'spt_5GBXwBVQufRCmwI1bNRIUo',
        'spt_7H9jPV9qWyp6V629038aXU',
        'spt_7LLfmKhGZI11XO0dO4xDI7',
        'spt_5UNWQJdUbO8Gbg9Qn3r52M',
        'spt_0gGd4WhPXBSgDX6fdOHcOw',
        'spt_1WvNgEoB66jmHodcj15Zi9',
        'spt_6S0JgJU2l6ds1EhZUJMQFk',
        'spt_5U1dINFKjJlYNOSdMrHlRh',
        'spt_3oB1lv9FWDKbNOUvdTw75Q',
        'spt_3rjcQ5VIWCN4q7UFetzdeO',
        'spt_3BWBxpXDxofgji3RKZPIz8',
        'spt_2Sf0qp9mTN2YJIAbDWCvSL',
        'spt_6CGGvCBHWqQ4HXtn5aLhbh',
        'spt_6zUWZmyi5MLOEynQ5wCI5f',
        'spt_3nGqUwkJHiLPDECMVrX1Sq',
        'spt_23jUmiOyAG9Dzq6Ayp9LUG',
        'spt_4x1fUORHa2EsxrQ6ZzAoQ0',
        'spt_6sJBvMCAi9NuNCxI9RDYDW',
        'spt_0UzTVrRT0KTsJDxmlcGfQG',
        'spt_6OzE2OdvV2tGAxSBsBuZ74',
        'spt_5Kh0ta0UY4uJ4g2CIdq9V9',
        'spt_2nSO7JYDbJrYbJmP39qUzj',
        'spt_2Bwp23pD4UVsSkchHDZw4F',
        'spt_0IdAjS2LRieBR3gzoazdAw',
        'spt_3Z1ArowingijWbVesn0aON',
        'spt_0zn7lYLmKeTdAva9gucVJG',
        'spt_4NfuHLESitkh66LOZeyzsu',
        'spt_5h0cBKxBX54CqPaQU6tJhk',
        'spt_4s1DRFQAYnDvXmKYFBUcYa',
        'spt_1TdtsDVivxc6PpkQdNuXdR',
        'spt_5j5vJBQTJARLJspItqVyvE',
        'spt_1fQjpmcx8iNIy1gKRelTD2',
        'spt_2knyDFP4xw9wZEWA98JX6b',
        'spt_5SrlFeZhl6SkP8gzRcFa0n',
        'spt_7hLz2ZikFy4ZwDZS12Z77n',
        'spt_0u5ikKYYDO2XGyYjNGQRGf',
        'spt_6IBIzIFj0W756sS7OITld5',
        'spt_5ptgjFDE2abY6Xwo4ytufN',
        'spt_3UjpgK0RqZLxsJqa4akrNn',
        'spt_2WpCywRd9h3riGjldGWHIB',
        'spt_1pKJ2DU2i3uu6a23ngLUby',
        'spt_0RzxSfLRSQmRJ3fFabRMsT',
        'spt_4uqZAHbX45ygzxhxkRwTwR',
        'spt_2BAhRYk5QrGfs5KNo9gHr4',
        'spt_77b4s2pD9ezxA8EVti2cJw',
        'spt_4HGrrevENLsGCTS9bwqUrm',
        'spt_4IiJbbRn328Zxw8mtHb7bo',
        'spt_1984OVQ0KnJW80MiZYOrFF',
        'spt_0Gdbr9myXctE3u0jKahkFo',
        'spt_2j3AXmye1FJXoGOXr6tufj',
        'spt_39NXoiwWy5aJFeC76TzW9v',
        'spt_3B3UoHY8tKJ6zmyYZhkDSZ',
        'spt_3FZ4GX2mWNn7XElse3fQWd',
        'spt_4R3mugkUqCALXgkwSptTbg',
        'spt_3S2k1UZ8n1KpMrOaImOif3',
        'spt_1L1VfizWn4DkFt602yD80U',
        'spt_4co1OIKlUOsNNVJFSZzO9N',
        'spt_7luDDYsfkSivBsoTz3BKMq',
        'spt_6JTiPLdbZD2e0tDsN15U1s',
        'spt_6jFvKq4gMkQ50joURHPGXO',
        'spt_2Gvp79Cmni6PX13CAlSGex',
        'spt_3x6FwiNj93pnxxMDNRA1IR',
        'spt_5Cf9nBDNc99UFkq9Yqap7Q',
        'spt_4fCHhderLwLacsIOIKgu3J',
        'spt_604MsLiPn50AblFYzOg1RD',
        'spt_4ZSYaCMxF2k6maN3KTP17F',
        'spt_78TTKBLrw5XIRty0KnyftQ',
        'spt_24Wn81dwdDeTCuB1BWGoVJ',
        'spt_4YkqEuVf1Jf2x2XDqJ2CvC',
        'spt_3JkGKNawown8MgcJsDw1WT',
        'spt_1OXwJdOOL0Mio8zgA01OFB',
        'spt_6hnfLIkvDl6pjlAe1YRGXY',
        'spt_3euFcFd5Dc7JAz6t7oKg7m',
        'spt_2bGV8Wgh1Kb4LPk1jyEnbg',
        'spt_1MTANbmLhUqJXlLuqADGE7',
        'spt_2RTF7MrLWGQJQRwVzg0fDz',
        'spt_0FflNqUFk4ODtAZuVuqgou',
        'spt_2v14NO80QYditUms7sbEIZ',
        'spt_0CkuQCslREF7yuvAqJXVuz',
        'spt_1xNqmjTeWon7iX8kbPKpZz',
        'spt_6fCJf6pkYTHfW1XPc1d4vO',
        'spt_4APrfmUo8KRrjCVuyoKvwY',
        'spt_0wATZebE9ZNj7fTjTdwiJB'
      ],
      true,
      true
    );
  }
}
