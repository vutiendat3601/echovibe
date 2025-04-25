from pydantic import BaseModel, Field
from app.event.schema.event_schema import EventSchema
from app.schema.tag_schema import TagSchema


class TrackArtistSchema(BaseModel):
    artist_id: str = Field(default=None, alias="artistId")
    is_active: bool = Field(default=True, alias="isActive")
    is_main_artist: bool = Field(default=False, alias="isMainArtist")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackDetailSchema(BaseModel):
    name: str
    description: str | None = Field(default=None, alias="description")
    thumbnail_file_key: str | None = Field(default=None,
                                           alias="thumbnailFileKey")
    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")
    official_released_date: str | None = Field(default=None,
                                               alias="officialReleasedDate")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackAudioSchema(BaseModel):
    file_m3u8_url: str | None = Field(default=None, alias="fileM3u8Url")
    audio_file_key: str | None = Field(default=None, alias="audioFileKey")
    is_active: bool = Field(default=True, alias="isActive")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackCreatedEvent(EventSchema):
    urn: str
    ref_code: str | None = Field(default=None, alias="refCode")
    detail: TrackDetailSchema
    is_released: bool = Field(default=False, alias="isReleased")
    is_public: bool = Field(default=False, alias="isPublic")
    is_active: bool = Field(default=True, alias="isActive")
    tags: list[TagSchema] = Field(default=[], alias="tags")
    track_artists: list[TrackArtistSchema] = Field(default=[],
                                                   alias="trackArtists")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackReleasedEvent(EventSchema):
    urn: str
    detail: TrackDetailSchema
    is_released: bool = Field(default=False, alias="isReleased")
    is_public: bool = Field(default=False, alias="isPublic")
    is_active: bool = Field(default=True, alias="isActive")
    ref_code: str | None = Field(default=None, alias="refCode")
    revision_number: int = Field(alias="revisionNumber")
    tags: list[TagSchema] = Field(default=[], alias="tags")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackUpdatedEvent(EventSchema):
    detail: TrackDetailSchema
    is_public: bool = Field(default=False, alias="isPublic")
    is_released: bool = Field(default=False, alias="isReleased")
    tags: list[TagSchema] = Field(default=[], alias="tags")
    track_artists: list[TrackArtistSchema] = Field(default=[],
                                                   alias="trackArtists")
    ref_code: str | None = Field(default=None, alias="refCode")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackDeletedEvent(EventSchema):
    is_active: bool = Field(default=True, alias="isActive")
    is_soft_deleted: bool = Field(alias="isSoftDeleted")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackAudioMappedEvent(EventSchema):
    track_audio: TrackAudioSchema = Field(alias="trackAudio")

    class Config:
        populate_by_name = True
        extra = "allow"
