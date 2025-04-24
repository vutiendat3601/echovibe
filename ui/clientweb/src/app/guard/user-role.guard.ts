import { EMPTY_RESOURCE_ACCESS } from '../model/resource-access';
import { Injectable } from '@angular/core';
import {
  ActivatedRouteSnapshot,
  CanActivate,
  GuardResult,
  MaybeAsync,
  Router,
  RouterStateSnapshot
} from '@angular/router';
import { ROLE_USER } from '../constant/constant';
import { AuthService } from '../service/auth.service';
import { ResourceAccessClaim } from '../model/resource-access';
@Injectable({
  providedIn: 'root'
})
export class UserRoleGuard implements CanActivate {
  readonly USER_ROLES = [ROLE_USER];

  constructor(
    private readonly authService: AuthService,
    private readonly router: Router
  ) {}

  canActivate(_route: ActivatedRouteSnapshot, _state: RouterStateSnapshot): MaybeAsync<GuardResult> {
    if (this.authService.isAuthenticated) {
      const resourceAccess: ResourceAccessClaim = this.authService.resourceAccess;
      if ((resourceAccess['echovibe'] || EMPTY_RESOURCE_ACCESS).roles.some((role) => this.USER_ROLES.includes(role))) {
        return true;
      }
    }
    this.router.navigate(['/auth/access-denied']);
    return false;
  }
}
