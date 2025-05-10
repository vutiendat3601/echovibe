from pydantic import BaseModel, Field


class ArtistStatsSchema(BaseModel):
    id: str = Field(alias="id")
    total_detail_page_views: int = Field(default=0,
                                         alias="totalDetailPageViews")
    total_likes: int = Field(default=0, alias="totalLikes")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True
