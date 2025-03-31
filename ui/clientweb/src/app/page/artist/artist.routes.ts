import { Routes } from '@angular/router';
import { ArtistDetailComponent } from './artist-detail/artist-detail.component';

export default [
  {
    path: ':id',
    component: ArtistDetailComponent
  },
  { path: '**', redirectTo: '/not-found' }
] as Routes;
