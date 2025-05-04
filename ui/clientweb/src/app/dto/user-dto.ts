export interface UserStatsDto {
  userId: string;
  data: any | null;
  updated_at: string;
  liked_track_ids: string[];
  liked_artist_ids: string[];
}
