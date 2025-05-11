from sqlmodel import SQLModel, Field, Column, Relationship
from typing import Optional
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import ARRAY, ENUM, JSONB
from sqlalchemy import TEXT


class ArtistLike(SQLModel, table=True):
    __tablename__ = "artist_like"
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


class ArtistDetailPageView(SQLModel, table=True):
    __tablename__ = "artist_detail_page_view"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    user_id: str = Field(..., max_length=255)
    duration_second: int = Field(default=0)
    session_id: str = Field(..., max_length=12)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class ArtistStats(SQLModel, table=True):
    __tablename__ = "artist_stats"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    total_detail_page_views: int = Field(default=0)
    total_likes: int = Field(default=0)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class ArtistRecommendation(SQLModel, table=True):
    __tablename__ = "artist_recommendation"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    most_popular_track_ids: list[str] = Field([],
                                              sa_column=Column(ARRAY(TEXT())))
    most_listened_track_ids: list[str] = Field([],
                                               sa_column=Column(ARRAY(TEXT())))
    most_listened_track_ids_current_month: list[str] = Field([],
                                                             sa_column=Column(
                                                                 ARRAY(TEXT())))
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class ArtistStatsDetail(SQLModel, table=True):
    __tablename__ = "v_artist_stats_detail"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    total_detail_page_views: int = Field(default=0)
    total_likes: int = Field(default=0)
    most_popular_track_ids: list[str] | None = Field(None,
                                                     sa_column=Column(
                                                         ARRAY(TEXT())))
    most_listened_track_ids: list[str] | None = Field(None,
                                                      sa_column=Column(
                                                          ARRAY(TEXT())))
    most_listened_track_ids_current_month: list[str] | None = Field(
        None, sa_column=Column(ARRAY(TEXT())))
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True
