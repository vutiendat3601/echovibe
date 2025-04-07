import { ArtistDto } from './artist-dto';

export interface SearchResultDto<T> {
  items: T[];
}

export interface SearchDto {
  keyword: string;
  artist: SearchResultDto<ArtistDto>;
}
