import { ArtistImage, ArtistProfile, ArtistRevision } from '../model/artist-profile';
import { Tag } from '../model/tag';

export interface ArtistDto {
  id: string;
  urn: string;
  refCode: string | null;
  profile: ArtistProfile;
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
