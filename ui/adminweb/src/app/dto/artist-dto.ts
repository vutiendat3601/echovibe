import { ArtistProfile } from '../model/artist-profile';

export interface CreateArtistProfileDto {
  name: string | null;
  description: string | null;
  biography: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  nationalityIsoCode: string | null;
}

export interface CreateArtistDto {
  profile: CreateArtistProfileDto;
  refCode: string | null;
  isVerified: boolean;
  tags: string[];
}

export interface DeleteArtistDto {
  id: string;
}
export interface ArtistDto {
  id: string;
  urn: string;
  refCode: string;
  profile: ArtistProfile;
  isPublic: boolean;
  isVerified: boolean;
  isReleased: boolean;
  tags: string[];
}

export interface UpdateArtistProfileDto {
  id: string;
  description: string | null;
  biography: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
}
