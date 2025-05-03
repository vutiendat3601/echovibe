from sqlmodel import SQLModel, Field, Column, Relationship
from typing import Optional
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import ARRAY, ENUM, JSONB
from sqlalchemy import TEXT
from app.model.artist import Artist


class Playlist(SQLModel, table=True):
    __tablename__ = "playlist"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    urn: str = Field(..., max_length=255, unique=True)
    name: str = Field(..., max_length=255)
    is_public: bool = Field(default=False)
    thumbnail_url: str | None = Field(None)
    track_ids: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
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
