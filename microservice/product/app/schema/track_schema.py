from pydantic import BaseModel, Field


class TrackArtistSchema(BaseModel):
    artist_id: str = Field(default=None, alias="artistId")
    is_active: bool = Field(default=True, alias="isActive")
    is_main_artist: bool = Field(default=False, alias="isMainArtist")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackDetailSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    name: str = Field()
    description: str | None = Field(default=None, alias="description")
    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")
    official_released_date: str | None = Field(default=None,
                                               alias="officialReleasedDate")
    is_public: bool = Field(default=False, alias="isPublic")
    tags: list[str] = Field(default=[], alias="tags")
    track_artists: list[TrackArtistSchema] | None = Field(default=[],
                                                          alias="trackArtists")

    class Config:
        populate_by_name = True
        extra = "allow"
