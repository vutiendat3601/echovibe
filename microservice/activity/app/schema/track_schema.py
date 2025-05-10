from pydantic import BaseModel, Field
from datetime import datetime


class TrackStatsSchema(BaseModel):
    id: str = Field(alias="id")
    total_detail_page_views: int = Field(default=0,
                                         alias="totalDetailPageViews")
    total_likes: int = Field(default=0, alias="totalLikes")
    total_listens: int = Field(default=0, alias="totalListens")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True
