from pydantic import BaseModel, Field
from app.enum.action_type import ActionType
from datetime import datetime


class UserStatsSchema(BaseModel):
    user_id: str | None = Field(default=None, alias="userId")
    data: dict[str, any] | None = Field(default=None, alias="data")
    updated_at: datetime = Field(alias="updatedAt")
    liked_track_ids: list[str] = Field([], alias="likedTrackIds")
    liked_artist_ids: list[str] = Field([], alias="likedArtistIds")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True
