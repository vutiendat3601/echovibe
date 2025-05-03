from sqlmodel import SQLModel, Field, Column
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy import TEXT


class Activity(SQLModel, table=True):
    __tablename__ = "activity"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    description: str | None = Field(None)
    type: str = Field(None)
    data_json: str | None = Field(None)
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)
