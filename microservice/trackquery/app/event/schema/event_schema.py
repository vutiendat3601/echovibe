from pydantic import BaseModel, Field
from datetime import datetime


class EventSchema(BaseModel):
    id: str
    type: str
    version: int
    created_by: str = Field(default=None, alias="createdBy")
    timestamp: datetime
