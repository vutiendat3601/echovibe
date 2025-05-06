export interface UserStatsDto {
  userId: string;
  data: any | null;
  updatedAt: string;
  likedTrackIds: string[];
  likedArtistIds: string[];
}
