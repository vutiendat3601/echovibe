import { ArtistImage, ArtistRevision } from '../model/artist';
import { Tag } from '../model/tag';

export interface ArtistProfileDto {
  name: string | null;
  description: string | null;
  biography: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  nationalityIsoCode: string | null;
}

export interface CreateArtistDto {
  profile: ArtistProfileDto;
  refCode: string | null;
  isPublic: boolean;
  tags: Tag[];
}

export interface DeleteArtistDto {
  id: string;
}

export interface ReleaseArtistDto {
  id: string;
}

export interface ArtistDto {
  id: string;
  urn: string;
  refCode: string | null;
  profile: ArtistProfileDto;
  isPublic: boolean;
  isReleased: boolean;
  isVerified: boolean;
  images: ArtistImage[] | null;
  revisionNumber: number;
  revisions: ArtistRevision[] | null;
  tags: Tag[];
  createdAt: string;
  updatedAt: string;
  createdBy: string | null;
  updatedBy: string | null;
}

export interface UpdateArtistDto {
  id: string;
  refCode: string | null;
  isPublic: boolean;
  tags: Tag[];
  profile: ArtistProfileDto;
}
