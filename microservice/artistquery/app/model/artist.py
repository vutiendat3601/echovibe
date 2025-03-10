from sqlmodel import SQLModel, Field, Column, text
from typing import Optional
import uuid
from datetime import datetime
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy import TEXT


class Artist(SQLModel, table=True):
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=16, unique=True)
    urn: str = Field(..., max_length=255, unique=True)
    name: str = Field(..., max_length=255)
    biography: str | None = Field(None, max_length=250)
    description: str | None = None
    is_public: bool = Field(default=False)
    is_published: bool = Field(default=False)
    is_active: bool = Field(default=True)
    thumbnail_file_key: str | None = None
    thumbnail_url: str | None = None
    background_file_key: str | None = None
    background_url: str | None = None
    tags: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    ref_code: str | None = Field(None, max_length=100, unique=True)
    event_timestamp: datetime = Field(None)
    created_at: datetime = Field(None)
    updated_at: datetime = Field(None)
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)
