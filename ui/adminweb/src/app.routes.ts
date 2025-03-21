import { Routes } from '@angular/router';
import { LayoutComponent } from './app/layout/component/layout/layout.component';
import { NotFoundComponent } from './app/page/not-found/not-found.component';
import { Landing } from './app/demo/landing/landing';
import { ManagerRole } from './app/guard/manager-role.guard';

export const routes: Routes = [
  {
    path: '',
    component: LayoutComponent,
    canActivate: [ManagerRole],
    children: [
      { path: 'management', loadChildren: () => import('./app/page/management/management.routes') },
      { path: 'system', loadChildren: () => import('./app/page/system/system.routes') }
    ]
  },
  { path: 'auth', loadChildren: () => import('./app/page/auth/auth.routes') },
  { path: 'not-found', component: NotFoundComponent },
  { path: 'demo', component: LayoutComponent, loadChildren: () => import('./app/demo/demo.routes') },
  { path: 'landing', component: Landing },
  { path: '**', redirectTo: '/not-found' }
];
