import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, map } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UrlValidator {
  constructor(private http: HttpClient) {}

  checkUrl(url: string): Observable<boolean> {
    return this.http.head(url, { observe: 'response' }).pipe(
      map((response) => response.status === 200),
      catchError(() => [false])
    );
  }

  checkUrlImage(url: string): Observable<boolean> {
    return this.http.head(url, { observe: 'response' }).pipe(
      map((response) => response.status === 200 && !!response.headers.get('content-type')?.startsWith('image')),
      catchError(() => [false])
    );
  }
}
