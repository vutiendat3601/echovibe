import { Routes } from '@angular/router';
import { TrackDetailComponent } from './track-detail/track-detail.component';

export const TRACK_ROUTES: Routes = [
  {
    path: ':id',
    component: TrackDetailComponent
  }
];
