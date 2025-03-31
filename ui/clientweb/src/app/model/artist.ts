import { ArtistProfile } from './artist-profile';
import { Tag } from './tag';

export interface Artist {
  id: string;
  urn: string;
  refCode: string | null;
  profile: ArtistProfile;
  isPublic: boolean;
  isReleased: boolean;
  isVerified: boolean;
  revisionNumber: number;
  tags: Tag[];
  createdAt: string;
  updatedAt: string;
  createdBy: string | null;
  updatedBy: string | null;
}
