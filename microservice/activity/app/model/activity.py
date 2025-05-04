from sqlmodel import SQLModel, Field, Column
import uuid
from datetime import datetime, timezone
from sqlalchemy.dialects.postgresql import JSONB


class Activity(SQLModel, table=True):
    __tablename__ = "activity"
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    aggregate_id: str = Field(..., max_length=12)
    session_id: str | None = Field(None, max_length=12)
    description: str | None = Field(None)
    type: str = Field(None)
    data_json: dict[str, any] | None = Field(None, sa_column=Column(JSONB))
    created_at: datetime = Field(default=datetime.now(timezone.utc))
    created_by: str | None = Field(None)

    class Config:
        arbitrary_types_allowed = True
