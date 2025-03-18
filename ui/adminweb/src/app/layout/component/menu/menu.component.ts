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
        label: 'Management',
        items: [
          { label: 'Artist', icon: 'pi pi-users', routerLink: ['/management/artist'] },
          { label: 'Track', icon: 'pi pi-tiktok', routerLink: ['/management/track'] },
          { label: 'Playlist', icon: 'pi pi-list', routerLink: ['/management/playlist'] }
        ]
      },
      {
        label: 'System',
        items: [{ label: 'Recommendation', icon: 'pi pi-wave-pulse', routerLink: ['/system/recommendation'] }]
      }
    ];
  }
}
