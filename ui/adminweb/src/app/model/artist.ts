import { ArtistProfile } from './artist-profile';

export interface Artist {
  id: string;
  urn: string;
  refCode: string;
  profile: ArtistProfile;
  isPublic: boolean;
  isReleased?: boolean;
  tags: string[];
}
