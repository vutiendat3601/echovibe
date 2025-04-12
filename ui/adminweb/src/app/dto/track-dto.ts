import { Tag } from '../model/tag';
import { TrackDetail, TrackImage, TrackRevision } from '../model/track';

export interface CreateTrackDetailDto {
  name: string | null;
  description: string | null;
  biography: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  nationalityIsoCode: string | null;
}

export interface CreateTrackDto {
  detail: CreateTrackDetailDto;
  refCode: string | null;
  isPublic: boolean;
  tags: Tag[];
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
}

export interface UpdateTrackDto {
  id: string;
  refCode: string | null;
  isPublic: boolean;
  tags: Tag[];
  detail: TrackDetail;
}
