from pydantic import BaseModel, Field
from datetime import datetime
from app.enum.track_image_type import TrackImageType
from app.schema.tag_schema import TagSchema


class TrackDetailSchema(BaseModel):
    name: str
    description: str | None = Field(default=None, alias="description")
    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")
    official_released_date: str | None = Field(default=None,
                                               alias="officialReleasedDate")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackImageSchema(BaseModel):
    url: str | None = Field(alias="url")
    type: TrackImageType = Field(alias="type")
    created_at: datetime | None = Field(alias="createdAt")
    created_by: str | None = Field(default=None, alias="createdBy")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackRevisionSchema(BaseModel):
    number: int = Field(0, alias="number")
    ref_code: str | None = Field(None, alias="refCode")
    name: str = Field(..., alias="name")
    urn: str = Field(..., alias="urn")
    is_public: bool = Field(False, alias="isPublic")
    is_released: bool = Field(False, alias="isReleased")
    is_active: bool = Field(True, alias="isActive")
    description: str | None = Field(None, alias="description")
    thumbnail_url: str | None = Field(None, alias="thumbnailUrl")
    official_released_date: str | None = Field(default=None,
                                               alias="officialReleasedDate")
    tags: list[TagSchema] = Field([], alias="tags")
    created_at: datetime = Field(alias="createdAt")
    created_by: str | None = Field(None, alias="createdBy")

    class Config:
        populate_by_name = True
        extra = "allow"


class TrackSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    ref_code: str | None = Field(default=None, alias="refCode")
    detail: TrackDetailSchema | None = Field(default=None, alias="detail")
    is_public: bool = Field(default=False, alias="isPublic")
    is_released: bool = Field(default=False, alias="isReleased")
    revision_number: int = Field(alias="revisionNumber")
    tags: list[TagSchema] = Field(default=[], alias="tags")
    images: list[TrackImageSchema] | None = Field(default=None, alias="images")
    revisions: list[TrackRevisionSchema] | None = Field(default=None,
                                                        alias="revisions")
    created_at: datetime = Field(alias="createdAt")
    updated_at: datetime = Field(alias="updatedAt")
    created_by: str | None = Field(default=None, alias="createdBy")
    updated_by: str | None = Field(default=None, alias="updatedBy")

    class Config:
        populate_by_name = True
        extra = "allow"
