import { HTTP_INTERCEPTORS, provideHttpClient, withFetch, withInterceptorsFromDi } from '@angular/common/http';
import { ApplicationConfig } from '@angular/core';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { provideRouter, withEnabledBlockingInitialNavigation, withInMemoryScrolling } from '@angular/router';
import Aura from '@primeng/themes/aura';
import { DefaultOAuthInterceptor, provideOAuthClient } from 'angular-oauth2-oidc';
import { providePrimeNG } from 'primeng/config';
import { routes } from './app.routes';
import { oauthModuleConfig } from './auth.config';
import { DomSanitizer } from '@angular/platform-browser';

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(
      routes,
      withInMemoryScrolling({ anchorScrolling: 'enabled', scrollPositionRestoration: 'enabled' }),
      withEnabledBlockingInitialNavigation()
    ),
    provideOAuthClient(oauthModuleConfig),
    provideHttpClient(withFetch(), withInterceptorsFromDi()),
    provideAnimationsAsync(),
    providePrimeNG({ theme: { preset: Aura, options: { darkModeSelector: '.app-dark' } } }),
    {
      provide: HTTP_INTERCEPTORS,
      useClass: DefaultOAuthInterceptor,
      multi: true
    }
  ]
};
