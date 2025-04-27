import { Tag } from '../model/tag';
import { TrackAudio, TrackDetail, TrackImage, TrackRevision } from '../model/track';

export interface TrackArtistDto {
  artistId: string | null;
  artistRefCode: string | null;
  isActive: boolean;
  isMainArtist: boolean;
}

export interface TrackDetailDto {
  name: string | null;
  description: string | null;
  thumbnailUrl: string | null;
  officialReleasedDate: string | null;
}

export interface CreateTrackDto {
  detail: TrackDetailDto;
  refCode: string | null;
  isPublic: boolean;
  tags: Tag[];
  trackArtists: TrackArtistDto[];
}

export interface DeleteTrackDto {
  id: string;
}

export interface ReleaseTrackDto {
  id: string;
}

export interface TrackDto {
  id: string;
  urn: string;
  refCode: string | null;
  detail: TrackDetail;
  isPublic: boolean;
  isReleased: boolean;
  isVerified: boolean;
  images: TrackImage[] | null;
  revisionNumber: number;
  revisions: TrackRevision[] | null;
  tags: Tag[];
  createdAt: string;
  updatedAt: string;
  createdBy: string | null;
  updatedBy: string | null;
  trackArtists: TrackArtistDto[];
  audio: TrackAudio | null;
}

export interface UpdateTrackDto {
  id: string;
  refCode: string | null;
  isPublic: boolean;
  tags: Tag[];
  detail: TrackDetailDto;
  trackArtists: TrackArtistDto[];
}

export interface MapTrackAudioDto {
  id: string;
  trackAudio: TrackAudio;
}
