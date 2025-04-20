from pydantic import BaseModel, Field


class ArtistDetailSchema(BaseModel):
    id: str = Field(alias="id")
    urn: str = Field(alias="urn")
    name: str = Field(alias="name")
    description: str | None = Field(default=None, alias="description")
    biography: str | None = Field(None, alias="biography")
    nationality_iso_code: str | None = Field(None, alias="nationalityIsoCode")
    thumbnail_url: str | None = Field(None, alias="thumbnailUrl")
    background_url: str | None = Field(None, alias="backgroundUrl")
    is_public: bool = Field(default=False, alias="isPublic")
    is_verified: bool = Field(default=False, alias="isVerified")
    tags: list[str] = Field([], alias="tags")

    class Config:
        populate_by_name = True
        extra = "allow"
