from sqlmodel import SQLModel, Field, Column, Relationship
from typing import Optional
import uuid
from datetime import datetime
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy import TEXT


class Artist(SQLModel, table=True):
    __tablename__ = "artist"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    urn: str = Field(..., max_length=255, unique=True)
    ref_code: str | None = Field(None, max_length=100, unique=True)
    is_public: bool = Field(default=False)
    is_released: bool = Field(default=False)
    is_active: bool = Field(default=True)
    tags: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    profile_id: uuid.UUID | None = Field(default=None,
                                         foreign_key="artist_profile.id")
    profile: Optional["ArtistProfile"] = Relationship(back_populates="artist")
    event_timestamp: datetime = Field(None)
    created_at: datetime = Field(None)
    updated_at: datetime = Field(None)
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)


class ArtistProfile(SQLModel, table=True):
    __tablename__ = "artist_profile"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    name: str = Field(..., max_length=255)
    biography: str | None = Field(None, max_length=250)
    description: str | None = None
    thumbnail_file_key: str | None = None
    thumbnail_url: str | None = None
    background_file_key: str | None = None
    background_url: str | None = None
    artist: Optional["Artist"] = Relationship(back_populates="profile")
    event_timestamp: datetime = Field(None)
    created_at: datetime = Field(None)
    updated_at: datetime = Field(None)
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)
