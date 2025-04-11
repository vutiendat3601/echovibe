from pydantic import BaseModel, Field
from datetime import datetime
from app.enum.artist_image_type import ArtistImageType
from app.schema.tag_schema import TagSchema

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
    url: str | None = Field(alias="url")
    type: ArtistImageType = Field(alias="type")
    created_at: datetime | None = Field(alias="createdAt")
    created_by: str | None = Field(default=None, alias="createdBy")

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistRevisionSchema(BaseModel):
    number: int = Field(0, alias="number")
    ref_code: str | None = Field(None, alias="refCode")
    name: str = Field(..., alias="name")
    urn: str = Field(..., alias="urn")
    is_public: bool = Field(False, alias="isPublic")
    is_released: bool = Field(False, alias="isReleased")
    is_verified: bool = Field(False, alias="isVerified")
    is_active: bool = Field(True, alias="isActive")
    description: str | None = Field(None, alias="description")
    biography: str | None = Field(None, alias="biography")
    nationality_iso_code: str | None = Field(None, alias="nationalityIsoCode")
    thumbnail_url: str | None = Field(None, alias="thumbnailUrl")
    background_url: str | None = Field(None, alias="backgroundUrl")
    tags: list[TagSchema] = Field([], alias="tags")
    created_at: datetime = Field(alias="createdAt")
    created_by: str | None = Field(None, alias="createdBy")

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    ref_code: str | None = Field(default=None, alias="refCode")
    profile: ArtistProfileSchema | None = Field(default=None, alias="profile")
    is_public: bool = Field(default=False, alias="isPublic")
    is_released: bool = Field(default=False, alias="isReleased")
    is_verified: bool = Field(default=False, alias="isVerified")
    revision_number: int = Field(alias="revisionNumber")
    tags: list[TagSchema] = Field(default=[], alias="tags")
    images: list[ArtistImageSchema] | None = Field(default=None, alias="images")
    revisions: list[ArtistRevisionSchema] | None = Field(default=None,
                                                         alias="revisions")
    created_at: datetime = Field(alias="createdAt")
    updated_at: datetime = Field(alias="updatedAt")
    created_by: str | None = Field(default=None, alias="createdBy")
    updated_by: str | None = Field(default=None, alias="updatedBy")

    class Config:
        populate_by_name = True
        extra = "allow"
