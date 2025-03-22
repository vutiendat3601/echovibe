import { ArtistProfile } from '../model/artist-profile';

export interface CreateArtistProfileDto {
  name: string;
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

export interface ArtistDto {
  id: string;
  urn: string;
  refCode: string;
  profile: ArtistProfile;
  isPublic: boolean;
  tags: string[];
}
