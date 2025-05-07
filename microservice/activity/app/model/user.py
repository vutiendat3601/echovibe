from sqlmodel import SQLModel, Field, Column
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy import TEXT


class UserData(SQLModel, table=True):
    __tablename__ = "user_data"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    user_id: str = Field(..., max_length=255)
    data_json: dict[str, any] | None = Field(None, sa_column=Column(JSONB))
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
    updated_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True


class UserUsageData(SQLModel, table=True):
    __tablename__ = "mv_user_usage_data"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    user_id: str = Field(..., max_length=255)
    data_json: dict[str, any] | None = Field(None, sa_column=Column(JSONB))
    updated_at: datetime = Field(default=datetime.now(timezone.utc))
    liked_track_ids: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    liked_artist_ids: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))
    created_playlist_ids: list[str] = Field([], sa_column=Column(ARRAY(TEXT())))

    class Config:
        arbitrary_types_allowed = True
