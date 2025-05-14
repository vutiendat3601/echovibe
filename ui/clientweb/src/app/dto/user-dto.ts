export interface UserUsageDto {
  userId: string;
  data: any | null;
  updatedAt: string;
  likedTrackIds: string[];
  likedArtistIds: string[];
  createdPlaylistIds: string[];
}

export interface UserRecommendationDto {
  userId: string;
  recommendedTrackIds: string[];
  mostPopularTrackIdsCurrentMonth: string[];
}
