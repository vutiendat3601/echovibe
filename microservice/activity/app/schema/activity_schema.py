from pydantic import BaseModel, Field


class CreateActivitySchema(BaseModel):
    type: str = Field(alias="type")
    data_json: dict[str, any] | None = Field(default=None, alias="dataJson")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True
