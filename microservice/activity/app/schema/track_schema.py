from pydantic import BaseModel, Field
from datetime import datetime


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
    audio_file_m3u8_url: str | None = Field(default=None,
                                            alias="audioFileM3u8Url")
    audio_duration_second: int | None = Field(default=None,
                                              alias="audioDurationSecond")
    tags: list[str] = Field(default=[], alias="tags")
    artists: list[TrackArtistSchema] = Field(default=[], alias="artists")


class TrackStatsSchema(BaseModel):
    id: str = Field(alias="id")
    total_detail_page_views: int = Field(default=0,
                                         alias="totalDetailPageViews")
    total_likes: int = Field(default=0, alias="totalLikes")
    total_listens: int = Field(default=0, alias="totalListens")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True
