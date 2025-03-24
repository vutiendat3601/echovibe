import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable, Optional } from '@angular/core';
import { OAuthModuleConfig, OAuthResourceServerErrorHandler, OAuthStorage } from 'angular-oauth2-oidc';
import { catchError, Observable } from 'rxjs';

@Injectable()
export class DefaultOAuthInterceptor implements HttpInterceptor {
  constructor(
    private readonly oauthStorage: OAuthStorage,
    private readonly errorHandler: OAuthResourceServerErrorHandler,
    private readonly oauthModuleConfig: OAuthModuleConfig
  ) {}

  private checkUrl(url: string): boolean {
    const found = this.oauthModuleConfig.resourceServer.allowedUrls?.find((baseUrl) => url.startsWith(baseUrl));
    return !!found;
  }

  public intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    if (req.url) {
      const url = req.url.toLowerCase();
      if (!this.oauthModuleConfig) return next.handle(req);
      if (!this.oauthModuleConfig.resourceServer) return next.handle(req);
      if (!this.oauthModuleConfig.resourceServer.allowedUrls) return next.handle(req);
      if (!this.checkUrl(url)) return next.handle(req);

      let sendAccessToken = this.oauthModuleConfig.resourceServer.sendAccessToken;

      if (sendAccessToken) {
        const accessToken = this.oauthStorage.getItem('access_token');
        const authorizationHeaderValue = `Bearer ${accessToken}`;
        const headers = req.headers.set('Authorization', authorizationHeaderValue);
        req = req.clone({ headers });
      }
    }
    return next.handle(req).pipe(catchError((error) => this.errorHandler.handleError(error)));
  }
}
