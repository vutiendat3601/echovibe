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

    class Config:
        arbitrary_types_allowed = True


class TrackDetailPageView(SQLModel, table=True):
    __tablename__ = "track_detail_page_view"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    user_id: str = Field(..., max_length=255)
    duration_second: int = Field(default=0)
    session_id: str = Field(..., max_length=12)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class TrackListen(SQLModel, table=True):
    __tablename__ = "track_listen"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    duration_second: int = Field(default=0)
    session_id: str = Field(..., max_length=12)
    user_id: str = Field(..., max_length=255)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class TrackStats(SQLModel, table=True):
    __tablename__ = "track_stats"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    user_id: str = Field(..., max_length=255)
    total_detail_page_views: int = Field(default=0)
    total_likes: int = Field(default=0)
    total_listens: int = Field(default=0)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True
