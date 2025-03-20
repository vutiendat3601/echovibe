from pydantic import BaseModel, Field


class ArtistProfileSchema(BaseModel):
    name: str
    biography: str | None = Field(default=None, alias="biography")
    description: str | None = Field(default=None, alias="description")
    thumbnail_file_key: str | None = Field(default=None,
                                           alias="thumbnailFileKey")
    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")
    background_file_key: str | None = Field(default=None,
                                            alias="backgroundFileKey")
    background_url: str | None = Field(default=None, alias="backgroundUrl")


class ArtistSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    profile: ArtistProfileSchema | None = Field(default=None)
    is_public: bool = Field(serialization_alias="isPublic")
    tags: list[str] = Field(default=[], serialization_alias="tags")
