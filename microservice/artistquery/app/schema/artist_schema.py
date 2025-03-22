from pydantic import BaseModel, Field


class ArtistProfileSchema(BaseModel):
    name: str
    description: str | None = Field(default=None,
                                    serialization_alias="description")
    biography: str | None = Field(default=None, serialization_alias="biography")
    nationality_iso_code: str | None = Field(
        default=None, serialization_alias="nationalityIsoCode")
    thumbnail_url: str | None = Field(default=None,
                                      serialization_alias="thumbnailUrl")
    background_url: str | None = Field(default=None,
                                       serialization_alias="backgroundUrl")


class ArtistSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    ref_code: str | None = Field(default=None, serialization_alias="refCode")
    profile: ArtistProfileSchema | None = Field(default=None)
    is_public: bool = Field(serialization_alias="isPublic")
    tags: list[str] = Field(default=[], serialization_alias="tags")
