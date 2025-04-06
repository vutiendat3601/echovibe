import { Routes } from '@angular/router';
import { SearchDetailComponent } from './search-detail/search-detail.component';

export default [
  {
    path: ':keyword',
    component: SearchDetailComponent
  },
  { path: '**', redirectTo: '/not-found' }
] as Routes;
