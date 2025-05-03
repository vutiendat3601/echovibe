from pydantic import BaseModel, Field
from app.schema.track_schema import TrackDetailSchema


class PlaylistDetailSchema(BaseModel):
    id: str = Field()
    urn: str = Field()
    name: str = Field()
    thumbnail_url: str | None = Field(default=None, alias="thumbnailUrl")
    is_public: bool = Field(default=False, alias="isPublic")
    tracks: list[TrackDetailSchema] = Field(default=[], alias="tracks")

    class Config:
        populate_by_name = True
        extra = "allow"
