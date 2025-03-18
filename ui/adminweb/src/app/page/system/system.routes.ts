import { Routes } from '@angular/router';
import { RecommendationSystemComponent } from '../system/recommendation-system/recommendation-system.component';

export default [
  {
    path: 'recommendation',
    component: RecommendationSystemComponent
  },
  { path: '**', redirectTo: '/not-found' }
] as Routes;
