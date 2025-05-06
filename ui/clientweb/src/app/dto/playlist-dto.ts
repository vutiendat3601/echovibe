import { TrackDetailDto } from './track-dto';

export interface CreatePlaylistDto {
  name: string;
  trackIds: string[];
  isPublic: boolean;
  thumbnailUrl: string | null;
}
export interface UpdatePlaylistDto {
  id: string;
  name: string;
  trackIds: string[];
  isPublic: boolean;
  thumbnailUrl: string | null;
}

export interface PlaylistDetailDto {
  id: string;
  urn: string;
  name: string;
  isPublic: boolean;
  thumbnailUrl: boolean;
  tracks: TrackDetailDto[];
  createdBy: string;
  updatedBy: string;
  createdAt: string;
  updatedAt: string;
}
