from pydantic import BaseModel, Field
from datetime import datetime, timezone


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


class ArtistSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    ref_code: str | None = Field(default=None, alias="refCode")
    profile: ArtistProfileSchema | None = Field(default=None, alias="profile")
    is_public: bool = Field(default=False, alias="isPublic")
    is_released: bool = Field(default=False, alias="isReleased")
    is_verified: bool = Field(default=False, alias="isVerified")
    revision_number: bool = Field(alias="revisionNumber")
    tags: list[str] = Field(default=[], alias="tags")
    created_at: datetime = Field(alias="createdAt")
    updated_at: datetime = Field(alias="updatedAt")
    created_by: str | None = Field(default=None, alias="createdBy")
    updated_by: str | None = Field(default=None, alias="updatedBy")

    class Config:
        populate_by_name = True
        extra = "allow"
