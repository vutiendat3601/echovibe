import { Routes } from '@angular/router';
import { SectionComponent } from './section.component';

export default [
  {
    path: ':type',
    component: SectionComponent
  }
] as Routes;
