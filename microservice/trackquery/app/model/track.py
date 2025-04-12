from sqlmodel import SQLModel, Field, Column, Relationship
from typing import Optional
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import ARRAY, ENUM, JSONB
from sqlalchemy import TEXT
from app.enum.track_image_type import TrackImageType


class Track(SQLModel, table=True):
    __tablename__ = "track"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    ref_code: str | None = Field(None, max_length=100, unique=True)
    urn: str = Field(..., max_length=255, unique=True)
    is_public: bool = Field(default=False)
    is_released: bool = Field(default=False)
    is_active: bool = Field(default=True)
    tags: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    tags_json: list[dict[str, any]] = Field([], sa_column=Column(JSONB))
    detail: Optional["TrackDetail"] = Relationship(back_populates="track")
    images: list["TrackImage"] = Relationship(back_populates="track")
    revision_number: int = Field(default=-1)
    revisions: list["TrackRevision"] = Relationship(back_populates="track")
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class TrackDetail(SQLModel, table=True):
    __tablename__ = "track_detail"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    track_id: uuid.UUID = Field(foreign_key="track.id")
    track: Track = Relationship(back_populates="detail")
    aggregate_id: str = Field(..., max_length=16, unique=True)
    ref_code: str | None = Field(..., max_length=100, unique=True)
    name: str = Field(..., max_length=255)
    description: str | None = Field(None, max_length=250)
    thumbnail_file_key: str | None = Field(None)
    thumbnail_url: str | None = Field(None)
    is_active: bool = Field(default=True)
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime | None = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class TrackImage(SQLModel, table=True):
    __tablename__ = "track_image"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    track_id: uuid.UUID = Field(foreign_key="track.id")
    track: Track = Relationship(back_populates="images")
    aggregate_id: str = Field(..., max_length=16)
    ref_code: str | None = Field(None, max_length=100)
    file_url: str | None = Field(None, max_length=255)
    file_key: str | None = Field(None, max_length=255)
    is_active: bool = Field(default=True)
    type: TrackImageType = Field(ENUM(TrackImageType))
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime | None = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class TrackRevision(SQLModel, table=True):
    __tablename__ = "track_revision"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    track_id: uuid.UUID = Field(foreign_key="track.id")
    track: Track = Relationship(back_populates="revisions")
    aggregate_id: str = Field(..., max_length=16)
    number: int = Field(default=0)
    ref_code: str | None = Field(None, max_length=100)
    name: str = Field(..., max_length=255)
    urn: str = Field(..., max_length=255)
    is_public: bool = Field(default=False)
    is_released: bool = Field(default=False)
    is_active: bool = Field(default=True)
    description: str | None = Field(None, max_length=250)
    biography: str | None = Field(None)
    nationality_iso_code: str | None = Field(None)
    thumbnail_url: str | None = Field(None)
    thumbnail_file_key: str | None = Field(None)
    background_url: str | None = Field(None)
    background_file_key: str | None = Field(None)
    tags_json: list[dict[str, any]] = Field([], sa_column=Column(JSONB))
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime | None = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True
