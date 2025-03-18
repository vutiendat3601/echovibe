import { Injectable } from '@angular/core';
import { OAuthService } from 'angular-oauth2-oidc';
import { authorizationCodePkceFlowConfig } from '../../auth.config';
import { filter } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  constructor(private readonly oauthService: OAuthService) {
    this.oauthService.configure(authorizationCodePkceFlowConfig);
    this.oauthService.loadDiscoveryDocumentAndLogin();
    this.oauthService.events.pipe(filter((event) => event.type === 'token_received')).subscribe((_) => this.oauthService.loadUserProfile());
  }

  signIn(): void {
    this.oauthService.initCodeFlow();
  }

  refreshToken(): void {
    this.oauthService.refreshToken();
  }

  get isAuthenticated(): boolean {
    return this.oauthService.hasValidAccessToken();
  }

  get userName(): string | null {
    const claims = this.oauthService.getIdentityClaims();
    if (!claims) {
      return null;
    }
    return claims['given_name'];
  }

  get idToken(): string {
    return this.oauthService.getIdToken();
  }

  get accessToken(): string {
    return this.oauthService.getAccessToken();
  }
}
