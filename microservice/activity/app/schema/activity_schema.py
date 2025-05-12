from pydantic import BaseModel, Field
from app.enum.action_type import ActionType
from app.enum.message_type import MessageType


class ActivitySchema(BaseModel):
    session_id: str | None = Field(default=None, alias="sessionId")
    aggregate_id: str | None = Field(default=None, alias="aggregateId")
    type: ActionType = Field(alias="type")
    data_json: dict[str, any] | None = Field(default=None, alias="dataJson")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True


class MessageResponseSchema(BaseModel):
    aggregate_id: str | None = Field(default=None, alias="aggregateId")
    session_id: str | None = Field(default=None, alias="sessionId")
    type: MessageType
    data_json: dict[str, any] | None = Field(default=None, alias="dataJson")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True
