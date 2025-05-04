import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MenuItem } from 'primeng/api';
import { MenuItemComponent } from '../menu-item/menu-item.component';

@Component({
  selector: 'app-menu',
  standalone: true,
  imports: [CommonModule, MenuItemComponent, RouterModule],
  templateUrl: './menu.component.html'
})
export class MenuComponent {
  model: MenuItem[] = [];

  ngOnInit() {
    this.model = [
      {
        label: $localize`:@@MENU_ITEM_LABEL_LIBRARY:Libary`,
        items: [
          {
            label: $localize`:@@MENU_ITEM_LABEL_MY_LIKED_TRACK_PLAYLIST:Liked songs`,
            icon: 'pi pi-heart-fill',
            routerLink: ['/me/liked-songs']
          },
          {
            label: 'Offline Library',
            icon: 'pi pi-cloud-download',
            routerLink: ['/offline-library']
          }
        ]
      }
    ];
  }
}
