from pydantic import BaseModel, Field


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


class ArtistSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    name: str = Field()
    description: str | None = Field(default=None)
    biography: str | None = Field(default=None)
    is_public: bool = Field(serialization_alias="isPublic")
    thumbnail_url: str | None = Field(default=None,
                                      serialization_alias="thumbnailUrl")
    background_url: str | None = Field(default=None,
                                       serialization_alias="backgroundUrl")
    tags: list[str] = Field(default=[], serialization_alias="tags")

    class Config:
        populate_by_name = True
        extra = "allow"


class ArtistDetailScheme(BaseModel):
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
