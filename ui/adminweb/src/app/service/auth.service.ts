import { Injectable } from '@angular/core';
import { OAuthService } from 'angular-oauth2-oidc';
import { BehaviorSubject, filter, Observable, Subject } from 'rxjs';
import { authorizationCodePkceFlowConfig } from '../../auth.config';
import { UserProfile } from '../model/user-profile';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private readonly userProfileSubject: Subject<UserProfile> = new BehaviorSubject<UserProfile>({});

  constructor(private readonly oauthService: OAuthService) {
    this.initialize();
  }

  private initialize(): void {
    this.oauthService.configure(authorizationCodePkceFlowConfig);
    this.oauthService.setupAutomaticSilentRefresh();
    this.oauthService.loadDiscoveryDocumentAndLogin().then((hasReceivedTokens) => hasReceivedTokens && this.loadUserProfile());
    this.oauthService.events.pipe(filter((event) => ['token_received', 'token_refreshed'].includes(event.type))).subscribe((_) => this.loadUserProfile());
  }

  private loadUserProfile() {
    this.oauthService.loadUserProfile().then((userProfile) => this.userProfileSubject.next(userProfile));
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
