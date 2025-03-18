import { HttpHandlerFn, HttpRequest } from '@angular/common/http';
import { inject } from '@angular/core';
import { AuthService } from '../service/auth.service';

export function tokenInterceptor(req: HttpRequest<unknown>, next: HttpHandlerFn) {
  const authService = inject(AuthService);

  const newReq = req.clone({
    headers: req.headers.append('Authorization', `Bearer ${authService.accessToken}`)
  });
  return next(newReq);
}
