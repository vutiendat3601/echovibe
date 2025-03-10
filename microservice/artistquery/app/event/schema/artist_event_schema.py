from pydantic import Field
from app.event.schema.event_schema import EventSchema


class ArtistCreatedEvent(EventSchema):
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


class ArtistUpdatedEvent(EventSchema):
    name: str

    biography: str | None = Field(default=None, alias="biography")

    description: str | None = Field(default=None, alias="description")

    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")

    background_url: str | None = Field(default=None, alias="backgroundUrl")

    ref_code: str | None = Field(default=None, alias="refCode")


class ArtistDeletedEvent(EventSchema):
    is_active: bool = Field(default=True, alias="isActive")

    is_soft_deleted: bool = Field(alias="isSoftDeleted")


class ArtistVisibilityChangedEvent(EventSchema):
    is_public: bool = Field(alias="isPublic")
