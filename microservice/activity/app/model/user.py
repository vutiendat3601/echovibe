from sqlmodel import SQLModel, Field, Column
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy import TEXT


class UserData(SQLModel, table=True):
    __tablename__ = "user_data"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    user_id: str = Field(..., max_length=255)
    data_json: dict[str, any] | None = Field(None, sa_column=Column(JSONB))
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class UserUsageData(SQLModel, table=True):
    __tablename__ = "mv_user_usage_data"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    user_id: str = Field(..., max_length=255)
    data_json: dict[str, any] | None = Field(None, sa_column=Column(JSONB))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    liked_track_ids: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    liked_artist_ids: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    created_playlist_ids: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))

    class Config:
        arbitrary_types_allowed = True


class UserPlaylist(SQLModel, table=True):
    __tablename__ = "user_playlist"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    playlist_id: str = Field(..., max_length=12)
    user_id: str = Field(..., max_length=255)
    is_active: bool = Field(default=True)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class UserTrackRating(SQLModel, table=False):
    __tablename__ = "v_user_track_rating"
    user_id: str = Field(..., max_length=255)
    track_id: str = Field(..., max_length=12)
    rating: float = Field(default=0)
    year: int | None = Field(default=None)
    month: int | None = Field(default=None)
    total_listened_seconds: int = Field(default=0)


class UserTrackRecommendation(SQLModel, table=True):
    __tablename__ = "user_track_recommendation"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    user_id: str = Field(..., max_length=255)
    track_ids: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    ratings_json: dict[str, any] = Field(sa_column=Column(JSONB))
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True
