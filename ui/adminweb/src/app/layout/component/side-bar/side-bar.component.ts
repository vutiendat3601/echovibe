import { Component, ElementRef } from '@angular/core';
import { MenuComponent } from '../menu/menu.component';

@Component({
  selector: 'app-side-bar',
  standalone: true,
  imports: [MenuComponent],
  template: ` <div class="layout-side-bar">
    <app-menu></app-menu>
  </div>`
})
export class SideBarComponent {
  constructor(public el: ElementRef) {}
}
