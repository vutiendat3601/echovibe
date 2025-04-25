import { SearchService } from './../../../service/search.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ArtistDetailDto } from '../../../dto/artist-dto';

interface ArtistDetail {
  id: string;
  urn: string;
  name: string;
  description: string | null;
  biography: string | null;
  nationalityIsoCode: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  isPublic: boolean;
  isVerified: boolean;
  tags: string[];
}

@Component({
  selector: 'app-search-detail',
  imports: [],
  templateUrl: './search-detail.component.html',
  styleUrl: './search-detail.component.scss'
})
export class SearchDetailComponent implements OnInit {
  private readonly PAGE_SIZE: number = 100;
  pageNumber: number = 0;
  readonly artistDetails: ArtistDetail[] = [];
  artistsJson: string | null = null;
  constructor(
    private readonly activeRoute: ActivatedRoute,
    private readonly searchService: SearchService
  ) {}

  ngOnInit(): void {
    this.loadData();
  }

  private mapToArtistDetail(artistDetailDto: ArtistDetailDto): ArtistDetail {
    const {
      id,
      urn,
      name,
      description,
      biography,
      nationalityIsoCode,
      thumbnailUrl,
      backgroundUrl,
      isPublic,
      isVerified,
      tags
    } = artistDetailDto;
    return {
      id,
      urn,
      name,
      description,
      biography,
      nationalityIsoCode,
      thumbnailUrl,
      backgroundUrl,
      isPublic,
      isVerified,
      tags
    };
  }

  private loadData(): void {
    this.activeRoute.params.subscribe((params) => {
      if (params['keyword']) {
        this.searchService.search(params['keyword'], this.pageNumber, this.PAGE_SIZE).subscribe((respDto) => {
          if (respDto.data) {
            const search = respDto.data;
            const artistDetails = search.artist.items.map((artistDetailDto) => this.mapToArtistDetail(artistDetailDto));
            this.artistDetails.push(...artistDetails);
            this.artistsJson = JSON.stringify(this.artistDetails);
            this.pageNumber++;
          }
        });
      }
    });
  }
}
