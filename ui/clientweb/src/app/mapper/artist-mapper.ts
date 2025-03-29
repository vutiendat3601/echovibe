import { Artist } from '../model/artist';
import { ArtistDto } from './../dto/artist-dto';
import { Injectable, Sanitizer } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ArtistMapper {
  constructor() {}

  mapToArtist(artistDto: ArtistDto): Artist {
    return {
      ...artistDto
    };
  }
}
