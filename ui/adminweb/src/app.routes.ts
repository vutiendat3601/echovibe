import { Routes } from '@angular/router';
import { LayoutComponent } from './app/layout/component/layout/layout.component';
import { NotFoundComponent } from './app/page/not-found/not-found.component';
import { AdminRoleGuard } from './app/guard/admin-role.guard';

export const routes: Routes = [
  {
    path: '',
    component: LayoutComponent,
    canActivate: [AdminRoleGuard],
    children: [
      { path: 'management', loadChildren: () => import('./app/page/management/management.routes') },
      { path: 'system', loadChildren: () => import('./app/page/system/system.routes') }
    ]
  },
  { path: 'auth', loadChildren: () => import('./app/page/auth/auth.routes') },
  { path: 'not-found', component: NotFoundComponent },
  { path: '**', redirectTo: '/not-found' }
];
