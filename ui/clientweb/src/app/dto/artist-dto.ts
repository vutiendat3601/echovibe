export interface ArtistDetailDto {
  id: string;
  urn: string;
  name: string;
  description: string | null;
  biography: string | null;
  nationalityIsoCode: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  isPublic: boolean;
  isVerified: boolean;
  tags: string[];
}

export interface ArtistStatsDto {
  id: string;
  totalDetailPageViews: number;
  totalLikes: number;
  mostListenedTrackIds: string[];
  mostListenedTrackIdsCurrentMonth: string[];
  mostPopularTrackIds: string[];
}
