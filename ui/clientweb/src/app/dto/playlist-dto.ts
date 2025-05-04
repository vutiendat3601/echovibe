import { TrackDto } from "./track-dto";

export interface PlaylistDto {
  id: string;
  name: string;
  description?: string;
  createdAt: number;
  updatedAt: number;
  coverImageUrl?: string;
  creatorName: string;
  isPublic: boolean;
  tracks: TrackDto[];
}