from pydantic import BaseModel, Field


class ArtistSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    name: str = Field()
    biography: str | None = Field(default=None)
    description: str | None = Field(default=None)
    is_public: bool = Field(serialization_alias="isPublic")
    thumbnail_url: str | None = Field(default=None,
                                      serialization_alias="thumbnailUrl")
    background_url: str | None = Field(default=None,
                                       serialization_alias="backgroundUrl")
    tags: list[str] = Field(default=[], serialization_alias="tags")
