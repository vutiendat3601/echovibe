from pydantic import BaseModel, Field
from typing import Generic, TypeVar
from app.schema.artist_schema import ArtistDetailSchema

T = TypeVar("T")


class SearchResult(BaseModel, Generic[T]):
    items: list[T]

    class Config:
        populate_by_name = True
        extra = "allow"


class SearchSchema(BaseModel):
    keyword: str = Field(alias="keyword")
    artist: SearchResult[ArtistDetailSchema] | None = Field(default=None)

    class Config:
        populate_by_name = True
        extra = "allow"
