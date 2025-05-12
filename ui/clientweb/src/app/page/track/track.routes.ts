import { Routes } from '@angular/router';
import { TrackDetailComponent } from './track-detail/track-detail.component';

export default [
  {
    path: ':id',
    component: TrackDetailComponent
  }
] as Routes;
