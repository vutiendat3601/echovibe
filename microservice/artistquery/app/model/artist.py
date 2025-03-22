from sqlmodel import SQLModel, Field, Column, Relationship
from typing import Optional
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import ARRAY, ENUM
from sqlalchemy import TEXT
from app.constant.artist_image_type import ArtistImageType


class Artist(SQLModel, table=True):
    __tablename__ = "artist"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    ref_code: str | None = Field(None, max_length=100, unique=True)
    urn: str = Field(..., max_length=255, unique=True)
    is_public: bool = Field(default=False)
    is_released: bool = Field(default=False)
    is_verified: bool = Field(default=False)
    is_active: bool = Field(default=True)
    tags: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    profile_id: uuid.UUID | None = Field(default=None,
                                         foreign_key="artist_profile.id")
    profile: Optional["ArtistProfile"] = Relationship(back_populates="artist")
    images: list["ArtistImage"] = Relationship(back_populates="artist")
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)


class ArtistProfile(SQLModel, table=True):
    __tablename__ = "artist_profile"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    artist_ref_code: str | None = Field(..., max_length=100, unique=True)
    name: str = Field(..., max_length=255)
    description: str | None = Field(None, max_length=250)
    biography: str | None = Field(None)
    nationality_iso_code: str | None = Field(None)
    thumbnail_file_key: str | None = Field(None)
    thumbnail_url: str | None = Field(None)
    background_file_key: str | None = Field(None)
    background_url: str | None = Field(None)
    artist: Optional["Artist"] = Relationship(back_populates="profile")
    is_active: bool = Field(default=True)
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime | None = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)


class ArtistImage(SQLModel, table=True):
    __tablename__ = "artist_image"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16)
    artist_ref_code: str | None = Field(..., max_length=100)
    file_url: str | None = Field(None, max_length=255)
    file_key: str | None = Field(None, max_length=255)
    is_active: bool = Field(default=True)
    type: ArtistImageType = Field(ENUM(ArtistImageType))
    artist_id: uuid.UUID = Field(foreign_key="artist.id")
    artist: Artist = Relationship(back_populates="images")
    event_type: str | None = Field(None)
    event_version: int | None = Field(None)
    event_timestamp: datetime | None = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)
