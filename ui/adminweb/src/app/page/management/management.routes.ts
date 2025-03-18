import { Routes } from '@angular/router';
import { ArtistManagementComponent } from './artist-management/artist-management.component';
import { TrackManagementComponent } from './track-management/track-management.component';
import { PlaylistManagementComponent } from './playlist-management/playlist-management.component';
import { RecommendationSystemComponent } from '../system/recommendation-system/recommendation-system.component';

export default [
  {
    path: 'artist',
    component: ArtistManagementComponent
  },
  {
    path: 'track',
    component: TrackManagementComponent
  },
  {
    path: 'playlist',
    component: PlaylistManagementComponent
  },
  {
    path: 'recommendation-system',
    component: RecommendationSystemComponent
  },
  { path: '**', redirectTo: '/not-found' }
] as Routes;
