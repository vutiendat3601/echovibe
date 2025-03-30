from pydantic import BaseModel, Field
from app.event.schema.event_schema import EventSchema
from app.schema.tag_schema import TagSchema
from app.schema.artist_schema import ArtistProfileSchema


class ArtistCreatedEvent(EventSchema):
    urn: str
    ref_code: str | None = Field(default=None, alias="refCode")
    profile: ArtistProfileSchema
    is_released: bool = Field(default=False, alias="isReleased")
    is_public: bool = Field(default=False, alias="isPublic")
    is_active: bool = Field(default=True, alias="isActive")
    is_verified: bool = Field(default=True, alias="isVerified")
    tags: list[TagSchema] = Field(default=[], alias="tags")

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistReleasedEvent(EventSchema):
    urn: str
    profile: ArtistProfileSchema
    is_released: bool = Field(default=False, alias="isReleased")
    is_verified: bool = Field(default=False, alias="isVerified")
    is_public: bool = Field(default=False, alias="isPublic")
    is_active: bool = Field(default=True, alias="isActive")
    ref_code: str | None = Field(default=None, alias="refCode")
    revision_number: int = Field(alias="revisionNumber")
    tags: list[TagSchema] = Field(default=[], alias="tags")

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistUpdatedEvent(EventSchema):
    profile: ArtistProfileSchema
    is_public: bool = Field(default=False, alias="isPublic")
    is_released: bool = Field(default=False, alias="isReleased")
    tags: list[TagSchema] = Field(default=[], alias="tags")

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistDeletedEvent(EventSchema):
    is_active: bool = Field(default=True, alias="isActive")
    is_soft_deleted: bool = Field(alias="isSoftDeleted")

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistVerificationSetEvent(EventSchema):
    is_verified: bool = Field(alias="isVerified")
    is_released: bool = Field(default=False, alias="isReleased")

    class Config:
        populate_by_name = True
        extra = "allow"
