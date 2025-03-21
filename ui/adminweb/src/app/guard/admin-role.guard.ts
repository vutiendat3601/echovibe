import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, GuardResult, MaybeAsync, Router, RouterStateSnapshot } from '@angular/router';
import { ROLE_ADMIN } from '../constant/constant';
import { AuthService } from '../service/auth.service';
@Injectable({
  providedIn: 'root'
})
export class AdminRoleGuard implements CanActivate {
  constructor(
    private readonly authService: AuthService,
    private readonly router: Router
  ) {}

  canActivate(_route: ActivatedRouteSnapshot, _state: RouterStateSnapshot): MaybeAsync<GuardResult> {
    if (this.authService.isAuthenticated) {
      const roles: string[] = this.authService.roles;
      roles.push(ROLE_ADMIN); // TODO: mock, need to remove
      if (roles.includes(ROLE_ADMIN)) {
        return true;
      }
    }
    this.router.navigate(['/auth/access-denied']);
    return false;
  }
}
