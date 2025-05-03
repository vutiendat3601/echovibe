from app.event.schema.event_schema import EventSchema
from pydantic import Field


class PlaylistCreatedEvent(EventSchema):
    urn: str
    track_ids: list[str] = Field(default=[], alias="trackIds")

    class Config:
        populate_by_name = True
        extra = "allow"
