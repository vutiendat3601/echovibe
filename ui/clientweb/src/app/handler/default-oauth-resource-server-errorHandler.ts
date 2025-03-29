import { HttpResponse } from '@angular/common/http';
import { OAuthResourceServerErrorHandler } from 'angular-oauth2-oidc';
import { Observable, of } from 'rxjs';

export class DefaultOAuthResourceServerErrorHandler implements OAuthResourceServerErrorHandler {
  handleError(err: HttpResponse<any>): Observable<any> {
    return of(err);
  }
}
