from pydantic import BaseModel, Field
from app.event.schema.event_schema import EventSchema
from app.schema.artist_schema import ArtistProfileSchema


class ArtistCreatedEvent(EventSchema):
    urn: str
    ref_code: str | None = Field(default=None, alias="refCode")
    profile: ArtistProfileSchema
    is_released: bool = Field(default=False, alias="isReleased")
    is_public: bool = Field(default=False, alias="isPublic")
    is_active: bool = Field(default=True, alias="isActive")

    class Config:
        populate_by_name = True
        extra = "allow"


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

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistDeletedEvent(EventSchema):
    is_active: bool = Field(default=True, alias="isActive")
    is_soft_deleted: bool = Field(alias="isSoftDeleted")

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistVisibilitySetEvent(EventSchema):
    is_public: bool = Field(alias="isPublic")

    class Config:
        populate_by_name = True
        extra = "allow"
