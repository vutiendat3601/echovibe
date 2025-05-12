from pydantic import BaseModel, Field


class ArtistStatsDetailSchema(BaseModel):
    id: str = Field(alias="id")
    total_detail_page_views: int = Field(default=0,
                                         alias="totalDetailPageViews")
    total_likes: int = Field(default=0, alias="totalLikes")
    most_popular_track_ids: list[str] = Field(default=[],
                                              alias="mostPopularTrackIds")
    most_listened_track_ids: list[str] = Field(default=[],
                                               alias="mostListenedTrackIds")
    most_listened_track_ids_current_month: list[str] = Field(
        default=[], alias="mostListenedTrackIdsCurrentMonth")

    class Config:
        populate_by_name = True
        extra = "allow"
        arbitrary_types_allowed = True
