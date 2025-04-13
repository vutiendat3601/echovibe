export interface TrackDetail {
  name: string | null;
  description: string | null;
  thumbnailUrl: string | null;
  officialReleasedDate: string | null;
}

export interface TrackImage {
  url: string;
  type: string;
  createdAt: string;
  createdBy: string | null;
}

export interface TrackRevision {
  number: number;
  refCode: string | null;
  name: string;
  urn: string;
  isPublic: boolean;
  isReleased: boolean;
  description: string | null;
  thumbnailUrl: string | null;
  tags: string[];
  createdAt: string;
  createdBy: string | null;
}
