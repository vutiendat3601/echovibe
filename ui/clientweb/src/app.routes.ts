import { Routes } from '@angular/router';
import { LayoutComponent } from './app/layout/component/layout/layout.component';
import { NotFoundComponent } from './app/page/not-found/not-found.component';

export const routes: Routes = [
  {
    // canActivate: [UserRoleGuard],
    path: '',
    component: LayoutComponent,
    children: [
      { path: 'artist', loadChildren: () => import('./app/page/artist/artist.routes') },
      { path: 'search', loadChildren: () => import('./app/page/search/search.routes') },
      { path: 'offline-library', loadChildren: () => import('./app/page/offline-library/offline-library.routes') }
    ]
  },
  { path: 'auth', loadChildren: () => import('./app/page/auth/auth.routes') },
  { path: 'not-found', component: NotFoundComponent },
  { path: '**', redirectTo: '/not-found' }
];
