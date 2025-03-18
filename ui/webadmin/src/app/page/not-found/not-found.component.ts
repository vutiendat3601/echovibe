import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { ButtonModule } from 'primeng/button';
import { FloatingConfiguratorComponent } from '../../layout/component/floating-configurator/floating-configurator.component';

@Component({
  selector: 'app-not-found',
  standalone: true,
  imports: [RouterModule, FloatingConfiguratorComponent, ButtonModule],
  templateUrl: './not-found.component.html'
})
export class NotFoundComponent {}
