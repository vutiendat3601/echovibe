from sqlmodel import SQLModel, Field, Column
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy import TEXT


class Artist(SQLModel, table=True):
    __tablename__ = "artist"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    urn: str = Field(..., max_length=255, unique=True)
    ref_code: str | None = Field(None, max_length=100)
    name: str = Field(..., max_length=255)
    description: str | None = Field(None, max_length=250)
    biography: str | None = Field(None)
    nationality_iso_code: str | None = Field(None)
    thumbnail_file_key: str | None = Field(None)
    thumbnail_url: str | None = Field(None)
    background_file_key: str | None = Field(None)
    background_url: str | None = Field(None)
    revision_number: int = Field(default=-1)
    is_public: bool = Field(default=False)
    is_released: bool = Field(default=False)
    is_verified: bool = Field(default=False)
    is_active: bool = Field(default=True)
    tags: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)


class ArtistDetail(SQLModel, table=True):
    __tablename__ = "mv_artist_detail"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    urn: str = Field(..., max_length=255, unique=True)
    name: str = Field(..., max_length=255)
    description: str | None = Field(None, max_length=250)
    biography: str | None = Field(None)
    nationality_iso_code: str | None = Field(None)
    thumbnail_file_key: str | None = Field(None)
    thumbnail_url: str | None = Field(None)
    background_file_key: str | None = Field(None)
    background_url: str | None = Field(None)
    is_public: bool = Field(default=False)
    is_verified: bool = Field(default=False)
    tags: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
