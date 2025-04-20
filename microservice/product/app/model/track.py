from sqlmodel import SQLModel, Field, Column, Relationship
from typing import Optional
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import ARRAY, ENUM, JSONB
from sqlalchemy import TEXT
from app.model.artist import Artist


class Track(SQLModel, table=True):
    __tablename__ = "track"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    urn: str = Field(..., max_length=255, unique=True)
    ref_code: str | None = Field(None, max_length=100, unique=True)
    name: str = Field(..., max_length=255)
    description: str | None = Field(None, max_length=250)
    is_public: bool = Field(default=False)
    is_released: bool = Field(default=False)
    revision_number: int = Field()
    thumbnail_file_key: str | None = Field(None)
    thumbnail_url: str | None = Field(None)
    audio_m3u8_file_url: str | None = Field(None)
    official_released_date: str | None = Field(None, max_length=16)
    tags: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    is_active: bool = Field(default=True)
    track_artists: list["TrackArtist"] = Relationship(back_populates="track")
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime | None = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class TrackDetail(SQLModel, table=True):
    __tablename__ = "mv_track_detail"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    urn: str = Field(..., max_length=255, unique=True)
    name: str = Field(..., max_length=255)
    description: str | None = Field(None, max_length=250)
    is_public: bool = Field(default=False)
    thumbnail_file_key: str | None = Field(None)
    thumbnail_url: str | None = Field(None)
    audio_m3u8_file_url: str | None = Field(None)
    official_released_date: str | None = Field(None, max_length=16)
    tags: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    artists_json: list[dict[str, any]] = Field([], sa_column=Column(JSONB))

    class Config:
        arbitrary_types_allowed = True


class TrackArtist(SQLModel, table=True):
    __tablename__ = "track_artist"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12, unique=True)
    track_id: uuid.UUID = Field(foreign_key="track.id")
    track: Track = Relationship(back_populates="track_artists")
    artist_id: uuid.UUID = Field(foreign_key="artist.id")
    artist_aggregate_id: str = Field(..., max_length=16)
    is_active: bool = Field(default=True)
    is_main_artist: bool = Field(default=False)
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime | None = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True
