import { ArtistDetailDto } from './artist-dto';

export interface SearchResultDto<T> {
  items: T[];
}

export interface SearchDto {
  keyword: string;
  artist: SearchResultDto<ArtistDetailDto>;
}
