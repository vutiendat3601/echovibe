from pydantic import BaseModel, Field


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
    profile: ArtistProfileSchema | None = Field(default=None)
    is_public: bool = Field(alias="isPublic")
    tags: list[str] = Field(default=[], alias="tags")

    class Config:
        populate_by_name = True
        extra = "allow"
