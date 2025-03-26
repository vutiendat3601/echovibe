import { ArtistProfile } from './artist-profile';

export interface Artist {
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
