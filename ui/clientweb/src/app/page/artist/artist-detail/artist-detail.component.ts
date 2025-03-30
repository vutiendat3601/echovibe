import { ArtistMapper } from './../../../mapper/artist-mapper';
import { ArtistService } from './../../../service/artist.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Artist } from '../../../model/artist';
import { ResponseDto } from '../../../dto/response-dto';
import { ArtistDto } from '../../../dto/artist-dto';

@Component({
  selector: 'app-artist-detail',
  imports: [],
  templateUrl: './artist-detail.component.html',
  styleUrl: './artist-detail.component.scss'
})
export class ArtistDetailComponent implements OnInit {
  artist: Artist | null = null;
  artistJson: string | null = null;

  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly artistService: ArtistService,
    private readonly router: Router,
    private readonly artistMapper: ArtistMapper
  ) {}

  ngOnInit(): void {
    this.loadData();
  }

  private loadData(): void {
    this.activeRoute.params.subscribe((params) => {
      if (params['id']) {
        this.artistService.getArtistById(params['id']).subscribe((respDto: ResponseDto<ArtistDto | null>) => {
          if (respDto.data) {
            this.artist = this.artistMapper.mapToArtist(respDto.data);
            this.artistJson = JSON.stringify(this.artist);
          } else {
            this.router.navigate(['/not-found']);
          }
        });
      } else {
        this.router.navigate(['/not-found']);
      }
    });
  }
}
