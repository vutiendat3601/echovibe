import { ArtistDetailDto } from './artist-dto';
import { TrackDetailDto } from './track-dto';

export interface SearchResultDto<T> {
  items: T[];
}

export interface SearchDto {
  keyword: string;
  artist: SearchResultDto<ArtistDetailDto>;
  track: SearchResultDto<TrackDetailDto>;
}
