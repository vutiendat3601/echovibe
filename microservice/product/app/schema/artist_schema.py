from pydantic import BaseModel, Field


class ArtistSchema(BaseModel):
    id: str = Field(..., serialization_alias="id")
    urn: str = Field(..., serialization_alias="urn")
    name: str = Field(..., serialization_alias="name")
    biography: str = Field(..., serialization_alias="name")
    description: str = Field(..., serialization_alias="description")
    is_public: bool = Field(..., serialization_alias="isPublic")
    thumbnail_url: str = Field(..., serialization_alias="thumbnailUrl")
    background_url: str = Field(..., serialization_alias="backgroundUrl")
    tags: list[str] = Field(..., serialization_alias="tags")
