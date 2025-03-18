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
    this.oauthService.loadDiscoveryDocument();
    this.oauthService.events.pipe(filter((event) => event.type === 'token_received')).subscribe((_) => this.oauthService.loadUserProfile());
  }

  signIn(): void {
    this.oauthService.initCodeFlow();
  }

  signOut(): void {
    this.oauthService.logOut();
  }

  refreshToken(): void {
    this.oauthService.refreshToken();
  }

  get authorities(): string[] {
    return [];
  }

  get isAuthenticated(): boolean {
    return this.oauthService.hasValidAccessToken();
  }

  get username(): string | null {
    if (this.isAuthenticated) {
      const claims = this.oauthService.getIdentityClaims();
      return claims && claims['preferred_username'];
    }
    return null;
  }

  get email(): string | null {
    if (this.isAuthenticated) {
      const claims = this.oauthService.getIdentityClaims();
      return claims && claims['email'];
    }
    return null;
  }

  get profilePicture(): string | null {
    if (this.isAuthenticated) {
      const claims = this.oauthService.getIdentityClaims();
      return claims && claims['profile_pic'];
    }
    return null;
  }

  get idToken(): string | null {
    if (this.isAuthenticated) {
      return this.oauthService.getIdToken();
    }
    return null;
  }

  get accessToken(): string | null {
    if (this.isAuthenticated) {
      return this.oauthService.getAccessToken();
    }
    return null;
  }
}
