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
  refCode: string | null;
  profile: ArtistProfile;
  isPublic: boolean;
  isReleased: boolean;
  isVerified: boolean;
  revisionNumber: number;
  tags: string[];
  createdAt: string;
  updatedAt: string;
  createdBy: string | null;
  updatedBy: string | null;
}

export interface UpdateArtistDto {
  id: string;
  refCode: string | null;
  isPublic: boolean;
  description: string | null;
  tags: string[];
  profile: ArtistProfile;
}
