import { ActivatedRouteSnapshot, CanActivate, GuardResult, MaybeAsync, Router, RouterStateSnapshot } from '@angular/router';
import { AuthService } from '../service/auth.service';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ArtistManagerRoleGuard implements CanActivate {
  constructor(
    private readonly authService: AuthService,
    private readonly router: Router
  ) {}

  canActivate(_route: ActivatedRouteSnapshot, _state: RouterStateSnapshot): MaybeAsync<GuardResult> {
    if (this.authService.isAuthenticated) {
      const authorities = this.authService.roles;
      // set mock roles
      authorities.push('admin');

      return authorities.includes('admin');
    }
    this.router.navigate(['/auth/access-denied']);
    return false;
  }
}
