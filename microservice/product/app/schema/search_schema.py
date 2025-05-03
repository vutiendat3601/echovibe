from pydantic import BaseModel, Field
from typing import Generic, TypeVar
from app.schema.artist_schema import ArtistDetailSchema
from app.schema.track_schema import TrackDetailSchema
from app.schema.playlist_schema import PlaylistDetailSchema

T = TypeVar("T")


class SearchResult(BaseModel, Generic[T]):
    items: list[T]

    class Config:
        populate_by_name = True
        extra = "allow"


class SearchSchema(BaseModel):
    keyword: str = Field(alias="keyword")
    artist: SearchResult[ArtistDetailSchema] | None = Field(default=None)
    track: SearchResult[TrackDetailSchema] | None = Field(default=None)
    playlist: SearchResult[PlaylistDetailSchema] | None = Field(default=None)

    class Config:
        populate_by_name = True
        extra = "allow"
