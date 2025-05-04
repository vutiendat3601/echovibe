import { Inject, Injectable, LOCALE_ID } from '@angular/core';
import { OAuthService } from 'angular-oauth2-oidc';
import { BehaviorSubject, filter, Observable, Subject } from 'rxjs';
import { authorizationCodePkceFlowConfig } from '../../auth.config';
import { UserProfile } from '../model/user-profile';
import { ResourceAccessClaim } from './../model/resource-access';
import { environment } from '../../environment/environment';
import { HttpClient } from '@angular/common/http';

interface ClientToken {
  access_token: string;
  expires_in: number;
  refresh_expires_in: number;
  token_type: string;
  'not-before-policy': number;
  scope: string;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private readonly userProfileSubject: Subject<UserProfile> = new BehaviorSubject<UserProfile>({});

  constructor(
    private readonly oauthService: OAuthService,
    private readonly http: HttpClient,
    @Inject(LOCALE_ID) private readonly locale: string
  ) {
    this.initialize();
  }

  private initialize(): void {
    if (environment.production) {
      authorizationCodePkceFlowConfig.redirectUri = `${window.location.origin}/${this.locale}/auth/oidc/callback`;
    }
    this.initializeClientToken();
    this.oauthService.configure(authorizationCodePkceFlowConfig);
    this.oauthService
      .loadDiscoveryDocumentAndTryLogin()
      .then((hasTokens) => hasTokens && setTimeout(() => this.loadUserProfile(), 1_000));
    this.oauthService.setupAutomaticSilentRefresh();
    this.oauthService.events
      .pipe(filter((event) => ['token_received', 'token_refreshed'].includes(event.type)))
      .subscribe((_) => setTimeout(() => this.loadUserProfile(), 1_500));
    this.oauthService.events
      .pipe(
        filter((event) =>
          [
            'user_profile_load_error',
            'token_error',
            'code_error',
            'token_refresh_error',
            'silent_refresh_error',
            'token_expires',
            'session_error',
            'invalid_nonce_in_state'
          ].includes(event.type)
        )
      )
      .subscribe((_) => setTimeout(() => this.oauthService.initCodeFlow(), 1_000));
  }

  private initializeClientToken() {
    this.http.post<ClientToken>(`${environment.gatewayBaseUrl}/client-token`, null).subscribe((token) => {
      localStorage.setItem('client-token', token.access_token);
      setTimeout(
        () => {
          this.initializeClientToken();
        },
        (token.expires_in - 10) * 1_000
      );
    });
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

  getAccessToken(): string {
    return this.oauthService.getAccessToken();
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
