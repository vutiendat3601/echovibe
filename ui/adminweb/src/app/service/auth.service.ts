import { ResourceAccessClaim } from './../model/resource-access';
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
    // this.oauthService.setupAutomaticSilentRefresh(); This command keep fetching Auth Server every a few ms
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

  get resourceAccess(): ResourceAccessClaim {
    const claims: Record<string, any> = this.oauthService.getIdentityClaims();
    let resourceAccess: ResourceAccessClaim = {};
    if (claims) {
      resourceAccess = claims['resource_access'] as ResourceAccessClaim;
    }
    return resourceAccess;
  }

  get isAuthenticated(): boolean {
    return this.oauthService.hasValidAccessToken();
  }

  userProfile(): Observable<UserProfile> {
    return this.userProfileSubject;
  }
}
