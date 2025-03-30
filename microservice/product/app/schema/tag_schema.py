from pydantic import BaseModel, Field


class TagSchema(BaseModel):
    name: str = Field(alias="name")
    is_active: bool = Field(default=False, alias="isActive")

    class Config:
        populate_by_name = True
        extra = "allow"
