import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { ButtonModule } from 'primeng/button';
import { RippleModule } from 'primeng/ripple';
import { FloatingConfiguratorComponent } from '../../../layout/component/floating-configurator/floating-configurator.component';
import { AuthService } from '../../../service/auth.service';

@Component({
  selector: 'app-access-denied',
  standalone: true,
  imports: [ButtonModule, RouterModule, RippleModule, FloatingConfiguratorComponent, ButtonModule],
  templateUrl: `./access-denied.component.html`
})
export class AccessDeniedComponent {
  constructor(private readonly authService: AuthService) {}

  signIn(): void {
    this.authService.signIn();
  }
}
