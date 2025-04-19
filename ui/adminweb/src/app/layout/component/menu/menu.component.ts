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
        label: $localize`:@@MENU_ITEM_LABEL_MANAGEMENT:Management`,
        items: [
          {
            label: $localize`:@@MENU_ITEM_LABEL_ARTIST:Artist`,
            icon: 'pi pi-users',
            routerLink: ['/management/artist']
          },
          { label: $localize`:@@MENU_ITEM_LABEL_TRACK:Track`, icon: 'pi pi-tiktok', routerLink: ['/management/track'] },
          {
            label: $localize`:@@MENU_ITEM_LABEL_AUDIO:Audio`,
            icon: 'pi pi-headphones',
            routerLink: ['/management/audio']
          },
          {
            label: $localize`:@@MENU_ITEM_LABEL_PLAYLIST:Playlist`,
            icon: 'pi pi-list',
            routerLink: ['/management/playlist']
          }
        ]
      },
      {
        label: $localize`:@@MENU_ITEM_LABEL_SYSTEM:System`,
        items: [
          {
            label: $localize`:@@MENU_ITEM_LABEL_RECOMMENDATION:Recommendation`,
            icon: 'pi pi-wave-pulse',
            routerLink: ['/system/recommendation']
          }
        ]
      }
    ];
  }
}
