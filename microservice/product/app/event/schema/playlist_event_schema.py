from app.event.schema.event_schema import EventSchema


class PlaylistCreatedEvent(EventSchema):
    class Config:
        populate_by_name = True
        extra = "allow"
