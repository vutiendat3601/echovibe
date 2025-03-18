import { Component, OnInit } from '@angular/core';
import { ArtistService } from '../../../service/artist.service';

@Component({
  selector: 'app-artist-management',
  imports: [],
  templateUrl: './artist-management.component.html',
  styleUrl: './artist-management.component.scss',
  providers: []
})
export class ArtistManagementComponent implements OnInit {
  constructor(private readonly artistService: ArtistService) {}

  ngOnInit(): void {}
}
