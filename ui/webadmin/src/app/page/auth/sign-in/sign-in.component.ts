import { AuthService } from '../../../service/auth.service';
import { OAuthService } from 'angular-oauth2-oidc';
import { Component, OnInit } from '@angular/core';
import { filter } from 'rxjs';

@Component({
  selector: 'app-sign-in',
  imports: [],
  templateUrl: './sign-in.component.html',
  styleUrl: './sign-in.component.scss'
})
export class SignInComponent implements OnInit {
  constructor(private readonly authService: AuthService) {}
  ngOnInit(): void {
    this.authService.signIn();
  }
}
