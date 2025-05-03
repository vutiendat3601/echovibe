from app.event.schema.event_schema import EventSchema
from pydantic import Field


class PlaylistCreatedEvent(EventSchema):
    urn: str = Field(..., alias="urn")
    name: str = Field(..., alias="name")
    is_public: bool = Field(default=False, alias="isPublic")
    thumbnail_url: str | None = Field(None, alias="thumbnailUrl")
    track_ids: list[str] = Field(default=[], alias="trackIds")

    class Config:
        populate_by_name = True
        extra = "allow"


class PlaylistUpdatedEvent(EventSchema):
    name: str = Field(..., alias="name")
    is_public: bool = Field(default=False, alias="isPublic")
    thumbnail_url: str | None = Field(None, alias="thumbnailUrl")
    track_ids: list[str] = Field(default=[], alias="trackIds")

    class Config:
        populate_by_name = True
        extra = "allow"


class PlaylistDeletedEvent(EventSchema):
    is_active: bool = Field(default=True, alias="isActive")
    is_soft_deleted: bool = Field(alias="isSoftDeleted")

    class Config:
        populate_by_name = True
        extra = "allow"
