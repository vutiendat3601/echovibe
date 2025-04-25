import { Tag } from './tag';
export interface ArtistProfile {
  name: string | null;
  description: string | null;
  biography: string | null;
  nationalityIsoCode: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
}

export interface ArtistImage {
  url: string;
  type: string;
  createdAt: string;
  createdBy: string | null;
}

export interface ArtistRevision {
  number: number;
  refCode: string | null;
  name: string;
  urn: string;
  isPublic: boolean;
  isReleased: boolean;
  isVerified: boolean;
  isActive: boolean | null;
  description: string | null;
  biography: string | null;
  nationalityIsoCode: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  tags: string[];
  createdAt: string;
  createdBy: string | null;
}

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
