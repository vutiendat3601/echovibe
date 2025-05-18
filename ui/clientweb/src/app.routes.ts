import { Routes } from '@angular/router';
import { LayoutComponent } from './app/layout/component/layout/layout.component';
import { NotFoundComponent } from './app/page/not-found/not-found.component';

export const routes: Routes = [
  {
    // canActivate: [UserRoleGuard],
    path: '',
    component: LayoutComponent,
    children: [
      { path: '', loadChildren: () => import('./app/page/home/home.routes') },
      { path: 'section', loadChildren: () => import('./app/page/home/section/section.routes') },
      { path: 'artist', loadChildren: () => import('./app/page/artist/artist.routes') },
      { path: 'search', loadChildren: () => import('./app/page/search/search.routes') },
      { path: 'offline-library', loadChildren: () => import('./app/page/offline-library/offline-library.routes') },
      { path: 'track', loadChildren: () => import('./app/page/track/track.routes') },
      { path: 'playlist', loadChildren: () => import('./app/page/playlist/playlist.routes') }
    ]
  },
  { path: 'auth', loadChildren: () => import('./app/page/auth/auth.routes') },
  { path: 'not-found', component: NotFoundComponent },
  { path: '**', redirectTo: '/not-found' }
];
