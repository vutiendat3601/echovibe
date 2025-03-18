from pydantic import BaseModel, Field
from app.event.schema.event_schema import EventSchema
from app.schema.artist_schema import ArtistProfileSchema


class ArtistCreatedEvent(EventSchema):
    urn: str
    profile: ArtistProfileSchema
    is_released: bool = Field(default=False, alias="isReleased")
    is_public: bool = Field(default=False, alias="isPublic")
    is_active: bool = Field(default=True, alias="isActive")


class ArtistReleasedEvent(EventSchema):
    urn: str
    profile: ArtistProfileSchema
    is_released: bool = Field(default=False, alias="isReleased")
    is_public: bool = Field(default=False, alias="isPublic")
    is_active: bool = Field(default=True, alias="isActive")
    tags: list[str] = Field(default=[])

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistProfileUpdatedEvent(EventSchema):
    profile: ArtistProfileSchema


class ArtistDeletedEvent(EventSchema):
    is_active: bool = Field(default=True, alias="isActive")
    is_soft_deleted: bool = Field(alias="isSoftDeleted")


class ArtistVisibilitySetEvent(EventSchema):
    is_public: bool = Field(alias="isPublic")
