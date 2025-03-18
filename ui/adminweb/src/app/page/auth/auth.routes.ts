import { Routes } from '@angular/router';
import { SignInComponent } from './sign-in/sign-in.component';
import { AccessDeniedComponent } from './access-denied/access-denied.component';

export default [
  { path: 'sign-in', component: SignInComponent },
  { path: 'access-denied', component: AccessDeniedComponent }
] as Routes;
