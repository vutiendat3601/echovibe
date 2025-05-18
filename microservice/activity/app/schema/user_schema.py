from pydantic import BaseModel, Field
from app.enum.recent_search_type import RecentSearchType
from datetime import datetime


class UserRecentSearchSchema(BaseModel):
    aggregate_id: str = Field(default=None, alias="aggregateId")
    name: str = Field(default=None, alias="name")
    thumbnail_url: str = Field(default=None, alias="thumbnailUrl")
    type: RecentSearchType = Field(default=None, alias="type")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True


class UserUsageDataSchema(BaseModel):
    user_id: str | None = Field(default=None, alias="userId")
    data: dict[str, any] | None = Field(default=None, alias="data")
    updated_at: datetime = Field(alias="updatedAt")
    liked_track_ids: list[str] = Field([], alias="likedTrackIds")
    liked_artist_ids: list[str] = Field([], alias="likedArtistIds")
    created_playlist_ids: list[str] = Field([], alias="createdPlaylistIds")
    recent_searches: list[UserRecentSearchSchema] = Field([],
                                                         alias="recentSearches")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True


class UserRecommendationSchema(BaseModel):
    user_id: str | None = Field(default=None, alias="userId")
    recommended_track_ids: list[str] = Field([], alias="recommendedTrackIds")
    most_popular_track_ids_current_month: list[str] = Field(
        [], alias="mostPopularTrackIdsCurrentMonth")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True
