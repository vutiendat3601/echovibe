from pydantic import BaseModel, Field
from app.event.schema.event_schema import EventSchema
from app.schema.tag_schema import TagSchema


class ArtistProfileSchema(BaseModel):
    name: str
    description: str | None = Field(default=None, alias="description")
    biography: str | None = Field(default=None, alias="biography")
    nationality_iso_code: str | None = Field(default=None,
                                             alias="nationalityIsoCode")
    thumbnail_file_key: str | None = Field(default=None,
                                           alias="thumbnailFileKey")
    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")
    background_file_key: str | None = Field(default=None,
                                            alias="backgroundFileKey")
    background_url: str | None = Field(default=None, alias="backgroundUrl")

    class Config:
        populate_by_name = True
        extra = "allow"


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

    class Config:
        populate_by_name = True
        extra = "allow"
