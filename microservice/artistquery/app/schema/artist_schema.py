from pydantic import BaseModel, Field
from datetime import datetime
from app.enum.artist_image_type import ArtistImageType
from enum import Enum


class ArtistProfileSchema(BaseModel):
    name: str
    description: str | None = Field(default=None, alias="description")
    biography: str | None = Field(default=None, alias="biography")
    nationality_iso_code: str | None = Field(default=None,
                                             alias="nationalityIsoCode")
    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")
    background_url: str | None = Field(default=None, alias="backgroundUrl")

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistImageSchema(BaseModel):
    url: str | None = Field(alias="fileUrl")
    type: ArtistImageType
    created_at: datetime = Field(alias="createdAt")
    created_by: str | None = Field(default=None, alias="createdBy")


class ArtistImageSchema(BaseModel):
    number: int = Field(default=0)
    ref_code: str | None = Field(None, max_length=100)
    name: str = Field(..., max_length=255)
    urn: str = Field(..., max_length=255)
    is_public: bool = Field(default=False)
    is_released: bool = Field(default=False)
    is_verified: bool = Field(default=False)
    is_active: bool = Field(default=True)
    description: str | None = Field(None, max_length=250)
    biography: str | None = Field(None)
    nationality_iso_code: str | None = Field(None)
    thumbnail_url: str | None = Field(None)
    thumbnail_file_key: str | None = Field(None)
    background_url: str | None = Field(None)
    tags: list[str] = Field([])
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime | None = Field(None)
    created_at: datetime = Field()
    updated_at: datetime = Field()
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)


class ArtistSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    ref_code: str | None = Field(default=None, alias="refCode")
    profile: ArtistProfileSchema | None = Field(default=None, alias="profile")
    is_public: bool = Field(default=False, alias="isPublic")
    is_released: bool = Field(default=False, alias="isReleased")
    is_verified: bool = Field(default=False, alias="isVerified")
    revision_number: int = Field(alias="revisionNumber")
    tags: list[str] = Field(default=[], alias="tags")
    created_at: datetime = Field(alias="createdAt")
    updated_at: datetime = Field(alias="updatedAt")
    created_by: str | None = Field(default=None, alias="createdBy")
    updated_by: str | None = Field(default=None, alias="updatedBy")

    class Config:
        populate_by_name = True
        extra = "allow"
