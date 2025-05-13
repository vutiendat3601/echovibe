export interface ArtistDetailOfTrack {
  id: string;
  urn: string;
  name: string;
  description: string | null;
  thumbnailUrl: string | null;
  isPublic: boolean;
  isVerified: boolean;
  isMainArtist: boolean; // Indicates if the artist is the main artist for the track
}

export interface TrackDetailDto {
  id: string;
  urn: string;
  name: string;
  description: string | null;
  thumbnailUrl: string | null;
  officialReleasedDate: string | null; // Date when the track was officially released
  isPublic: boolean;
  audioFileM3u8Url: string | null; // URL to the audio file in M3U8 format
  audioDurationSecond: number | null; // Duration of the audio in seconds
  tags: string[]; // Tags associated with the track
  artists: ArtistDetailOfTrack[]; // List of artists associated with the track
}

export interface TrackStatsDto {
  id: string;
  totalDetailPageViews: number;
  totalLikes: number;
  totalListens: number;
}
