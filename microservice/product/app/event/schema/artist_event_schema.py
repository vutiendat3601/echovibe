from pydantic import Field
from typing import List, Optional
from app.event.schema.event_schema import EventSchema


class ArtistPublishedEvent(EventSchema):
    urn: str
    name: str
    biography: str | None = Field(default=None, alias="biography")
    description: str | None = Field(default=None, alias="description")
    is_published: bool = Field(default=False, alias="isPublished")
    is_public: bool = Field(default=False, alias="isPublic")
    is_active: bool = Field(default=True, alias="isActive")
    thumbnail_file_key: str | None = Field(default=None,
                                           alias="thumbnailFileKey")
    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")
    background_file_key: str | None = Field(default=None,
                                            alias="backgroundFileKey")
    background_url: str | None = Field(default=None, alias="backgroundUrl")
    tags: list[str] = Field(default=[])
    ref_code: str | None = Field(default=None, alias="refCode")

    class Config:
        populate_by_name = True
        extra = "allow"
