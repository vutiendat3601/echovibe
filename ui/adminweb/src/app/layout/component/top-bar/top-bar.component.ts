import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MenuItem } from 'primeng/api';
import { StyleClassModule } from 'primeng/styleclass';
import { UserProfile } from '../../../model/user-profile';
import { ArtistService } from '../../../service/artist.service';
import { AuthService } from '../../../service/auth.service';
import { LayoutService } from '../../service/layout.service';
import { ConfiguratorComponent } from '../configurator/configurator.component';
import { AvatarModule } from 'primeng/avatar';

@Component({
  selector: 'app-top-bar',
  standalone: true,
  imports: [RouterModule, CommonModule, StyleClassModule, ConfiguratorComponent, AvatarModule],
  templateUrl: './top-bar.component.html'
})
export class TopBarComponent implements OnInit {
  items!: MenuItem[];
  userProfile: UserProfile = {};

  constructor(
    public readonly layoutService: LayoutService,
    public readonly authService: AuthService,
    private readonly artistService: ArtistService
  ) {}

  ngOnInit(): void {
    this.authService.userProfile().subscribe((userProfile) => ((this.userProfile = userProfile), console.log(userProfile)));
  }

  toggleDarkMode(): void {
    this.layoutService.layoutConfig.update((state) => ({ ...state, darkTheme: !state.darkTheme }));
  }

  redirectToProfileUrl(): void {}

  signOut(): void {
    this.authService.signOut();
  }
}
