from pydantic import BaseModel, Field
from app.event.schema.event_schema import EventSchema
from app.schema.tag_schema import TagSchema


class TrackDetailSchema(BaseModel):
    name: str
    description: str | None = Field(default=None, alias="description")
    thumbnail_file_key: str | None = Field(default=None,
                                           alias="thumbnailFileKey")
    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")

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

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackDeletedEvent(EventSchema):
    is_active: bool = Field(default=True, alias="isActive")
    is_soft_deleted: bool = Field(alias="isSoftDeleted")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackVerificationSetEvent(EventSchema):
    is_verified: bool = Field(alias="isVerified")
    is_released: bool = Field(default=False, alias="isReleased")

    class Config:
        populate_by_name = True
        extra = "allow"
