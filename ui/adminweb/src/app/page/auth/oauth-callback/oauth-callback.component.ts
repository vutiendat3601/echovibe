import { Router } from '@angular/router';
import { AuthService } from './../../../service/auth.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-oauth-callback',
  imports: [],
  templateUrl: './oauth-callback.component.html'
})
export class OauthCallbackComponent implements OnInit {
  constructor(
    private readonly authService: AuthService,
    private readonly router: Router
  ) {}

  ngOnInit(): void {
    setTimeout(() => {
      this.authService.isAuthenticated ? this.router.navigate(['/']) : this.authService.signIn();
    }, 1_500);
  }
}
