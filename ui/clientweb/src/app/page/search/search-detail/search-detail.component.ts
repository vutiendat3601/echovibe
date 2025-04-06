import { SearchService } from './../../../service/search.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ArtistService } from '../../../service/artist.service';
import { ArtistMapper } from '../../../mapper/artist-mapper';
import { Artist } from '../../../model/artist';

@Component({
  selector: 'app-search-detail',
  imports: [],
  templateUrl: './search-detail.component.html',
  styleUrl: './search-detail.component.scss'
})
export class SearchDetailComponent implements OnInit {
  private readonly PAGE_SIZE: number = 100;
  pageNumber: number = 0;
  readonly artists: Artist[] = [];
  artistsJson: string | null = null;
  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly searchService: SearchService,
    private readonly artistMapper: ArtistMapper
  ) {}

  ngOnInit(): void {
    this.loadData();
  }

  private loadData(): void {
    this.activeRoute.params.subscribe((params) => {
      if (params['keyword']) {
        this.searchService.search(params['keyword'], this.pageNumber, this.PAGE_SIZE).subscribe((respDto) => {
          if (respDto.data) {
            const search = respDto.data;
            const artists = search.artist.items.map((artistDto) => this.artistMapper.mapToArtist(artistDto));
            this.artists.push(...artists);
            this.artistsJson = JSON.stringify(this.artists);
            this.pageNumber++;
          }
        });
      }
    });
  }
}
