from sqlmodel import SQLModel, Field
import uuid
from datetime import datetime, timezone


class TrackLike(SQLModel, table=True):
    __tablename__ = "track_like"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    user_id: str = Field(..., max_length=255)
    is_active: bool = Field(default=True)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)


class TrackDetailPageView(SQLModel, table=True):
    __tablename__ = "track_detail_page_view"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    user_id: str = Field(..., max_length=255)
    duration_second: int = Field(default=0)
    session_id: str = Field(..., max_length=12)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)


class TrackListen(SQLModel, table=True):
    __tablename__ = "track_listen"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    duration_second: int = Field(default=0)
    session_id: str = Field(..., max_length=12)
    user_id: str = Field(..., max_length=255)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)


class TrackStats(SQLModel, table=True):
    __tablename__ = "track_stats"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    total_detail_page_views: int = Field(default=0)
    total_likes: int = Field(default=0)
    total_listens: int = Field(default=0)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)


class TrackStatsReport(SQLModel, table=False):
    __tablename__ = "v_artist_stats_report"
    aggregate_id: str = Field(..., max_length=12)
    year: int | None = Field(default=None)
    month: int | None = Field(default=None)
    total_track_detail_page_view_duration_seconds: int = Field(default=0)
    total_track_listen_duration_seconds: int = Field(default=0)
    total_track_detail_page_views: int = Field(default=0)
    total_track_listens: int = Field(default=0)
    score: int = Field(default=0)
