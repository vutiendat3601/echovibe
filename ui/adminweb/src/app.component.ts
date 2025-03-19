import { Component, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AuthService } from './app/service/auth.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './app.component.html'
})
export class AppComponent implements OnInit {
  constructor(private readonly authService: AuthService) {}

  ngOnInit(): void {
    this.authService.initialize();
  }
}
