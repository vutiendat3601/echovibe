import { RecentSearchType } from '../constant/recent-search-type';

export interface UserRecentSearchDto {
  aggregateId: string;
  name: string;
  thumbnailUrl: string | null;
  type: RecentSearchType;
}

export interface UserUsageDto {
  userId: string;
  data: any | null;
  updatedAt: string;
  likedTrackIds: string[];
  likedArtistIds: string[];
  createdPlaylistIds: string[];
  recentSearches: UserRecentSearchDto[];
}

export interface UserRecommendationDto {
  userId: string;
  recommendedTrackIds: string[];
  mostPopularTrackIdsCurrentMonth: string[];
}
