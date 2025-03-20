export interface CreateArtistProfileDto {
  name: string;
  biography: string | null;
  description: string | null;
  thumbnailUrl: string | null;
  backgroundUrl: string | null;
  refCode: string | null;
}

export interface CreateArtistDto {
  profile: CreateArtistProfileDto;
}
