from pydantic import BaseModel, Field
from app.enum.action_type import ActionType
from datetime import datetime


class UserUsageDataSchema(BaseModel):
    user_id: str | None = Field(default=None, alias="userId")
    data: dict[str, any] | None = Field(default=None, alias="data")
    updated_at: datetime = Field(alias="updatedAt")
    liked_track_ids: list[str] = Field([], alias="likedTrackIds")
    liked_artist_ids: list[str] = Field([], alias="likedArtistIds")
    created_playlist_ids: list[str] = Field([], alias="createdPlaylistIds")

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
