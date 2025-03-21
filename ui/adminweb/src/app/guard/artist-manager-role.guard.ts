import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, GuardResult, MaybeAsync, Router, RouterStateSnapshot } from '@angular/router';
import { ROLE_ARTIST_MANAGER } from '../constant/constant';
import { AuthService } from '../service/auth.service';

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
      const roles: string[] = this.authService.roles;
      roles.push(ROLE_ARTIST_MANAGER); // TODO: mock, need to remove
      if (roles.includes(ROLE_ARTIST_MANAGER)) {
        return true;
      }
    }
    this.router.navigate(['/auth/access-denied']);
    return false;
  }
}
