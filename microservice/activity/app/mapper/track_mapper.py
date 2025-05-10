from app.model.track import TrackStats
from app.schema.track_schema import TrackStatsSchema


def map_to_track_stats_schema(track_stats: TrackStats) -> TrackStatsSchema:

    return TrackStatsSchema(
        id=track_stats.aggregate_id,
        total_detail_page_views=track_stats.total_detail_page_views,
        total_likes=track_stats.total_likes,
        total_listens=track_stats.total_listens)
