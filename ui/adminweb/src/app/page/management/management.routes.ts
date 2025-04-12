import { Routes } from '@angular/router';
import { RecommendationSystemComponent } from '../system/recommendation-system/recommendation-system.component';
import { ArtistManagementComponent } from './artist-management/artist-management.component';
import { PlaylistManagementComponent } from './playlist-management/playlist-management.component';
import { TrackManagementComponent } from './track-management/track-management.component';
import { ArtistManagementBulkComponent } from './artist-management-bulk/artist-management-bulk.component';

export default [
  {
    path: 'artist',
    children: [
      {
        path: '',
        component: ArtistManagementComponent
      },
      {
        path: 'bulk',
        component: ArtistManagementBulkComponent
      }
    ]
    // canActivate: [ArtistManagerRoleGuard]
  },
  {
    path: 'track',
    children: [
      {
        path: '',
        component: TrackManagementComponent
      }
    ]
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
