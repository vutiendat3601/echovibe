import { TestBed } from '@angular/core/testing';
import { CanActivateFn } from '@angular/router';

import { artistManagerRoleGuardGuard } from './artist-manager-role-guard.guard';

describe('artistManagerRoleGuardGuard', () => {
  const executeGuard: CanActivateFn = (...guardParameters) => 
      TestBed.runInInjectionContext(() => artistManagerRoleGuardGuard(...guardParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeGuard).toBeTruthy();
  });
});
