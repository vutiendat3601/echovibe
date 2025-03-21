import { Injectable } from '@angular/core';
import { OAuthService } from 'angular-oauth2-oidc';
import { BehaviorSubject, Observable, Subject } from 'rxjs';
import { authorizationCodePkceFlowConfig } from '../../auth.config';
import { UserProfile } from '../model/user-profile';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private isInitialized: boolean = false;
  private readonly userProfileSubject: Subject<UserProfile> = new BehaviorSubject<UserProfile>({});

  constructor(private readonly oauthService: OAuthService) {}

  initialize(): void {
    if (this.isInitialized) {
      return;
    }
    this.oauthService.configure(authorizationCodePkceFlowConfig);
    this.oauthService.loadDiscoveryDocumentAndLogin().then((isLoggedIn) => {
      if (isLoggedIn) {
        this.oauthService.refreshToken();
      }
    });
    this.oauthService.setupAutomaticSilentRefresh();
    this.oauthService.events.forEach((event) => {
      if (['token_received', 'token_refreshed'].includes(event.type)) {
        this.oauthService.loadUserProfile().then((userProfile) => this.userProfileSubject.next(userProfile));
      }
    });
    this.isInitialized = true;
  }

  signIn(): void {
    this.oauthService.initCodeFlow();
  }

  signOut(): void {
    this.oauthService.revokeTokenAndLogout();
  }

  refreshToken(): void {
    this.oauthService.refreshToken();
  }

  get roles(): string[] {
    return [];
  }

  get isAuthenticated(): boolean {
    return this.oauthService.hasValidAccessToken();
  }

  userProfile(): Observable<UserProfile> {
    return this.userProfileSubject;
  }
}
