import { Routes } from '@angular/router';
import { AccessDeniedComponent } from './access-denied/access-denied.component';
import { OauthCallbackComponent } from './oauth-callback/oauth-callback.component';

export default [
  { path: 'access-denied', component: AccessDeniedComponent },
  { path: 'oidc/callback', component: OauthCallbackComponent }
] as Routes;
