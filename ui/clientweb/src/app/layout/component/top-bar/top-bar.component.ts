import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MenuItem } from 'primeng/api';
import { AvatarModule } from 'primeng/avatar';
import { StyleClassModule } from 'primeng/styleclass';
import { UserProfile } from '../../../model/user-profile';
import { AuthService } from '../../../service/auth.service';
import { LayoutService } from '../../service/layout.service';
import { ConfiguratorComponent } from '../configurator/configurator.component';
import { InputTextModule } from 'primeng/inputtext';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';

interface TopBarActionMenuItem {
  [key: string]: MenuItem;
}

@Component({
  selector: 'app-top-bar',
  standalone: true,
  imports: [
    RouterModule,
    CommonModule,
    StyleClassModule,
    ConfiguratorComponent,
    AvatarModule,
    InputTextModule,
    IconFieldModule,
    InputIconModule
  ],
  templateUrl: './top-bar.component.html'
})
export class TopBarComponent implements OnInit {
  items!: MenuItem[];
  userProfile: UserProfile = {};
  actionMenuItems: TopBarActionMenuItem = { profile: { label: $localize`:@@MENU_ITEM_LABEL_USER_PROFILE:Profile` } };
  constructor(
    public readonly layoutService: LayoutService,
    public readonly authService: AuthService
  ) {}

  ngOnInit(): void {
    this.authService.userProfile().subscribe((userProfile) => (this.userProfile = userProfile));
  }

  toggleDarkMode(): void {
    this.layoutService.layoutConfig.update((state) => ({ ...state, darkTheme: !state.darkTheme }));
  }

  redirectToProfileUrl(): void {}

  signOut(): void {
    this.authService.signOut();
  }
}
