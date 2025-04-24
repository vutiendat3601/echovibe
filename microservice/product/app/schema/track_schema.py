from pydantic import BaseModel, Field
from app.schema.artist_schema import ArtistDetailSchema


class TrackArtistSchema(BaseModel):
    id: str = Field(alias="id")
    urn: str = Field(alias="urn")
    name: str = Field(alias="name")
    thumbnail_url: str | None = Field(None, alias="thumbnailUrl")
    is_public: bool = Field(default=False, alias="isPublic")
    is_verified: bool = Field(default=False, alias="isVerified")
    is_main_artist: bool = Field(default=False, alias="isMainArtist")

    class Config:
        populate_by_name = True


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
    artists: list[TrackArtistSchema] = Field(default=[], alias="artists")

    class Config:
        populate_by_name = True
        extra = "allow"
