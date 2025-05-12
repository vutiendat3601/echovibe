from app.model.artist import ArtistStatsDetail
from app.schema.artist_schema import ArtistStatsDetailSchema


def map_to_artist_stats_detail_schema(
        artist_stats_detail: ArtistStatsDetail) -> ArtistStatsDetailSchema:
    most_popular_track_ids = artist_stats_detail.most_popular_track_ids if artist_stats_detail.most_popular_track_ids else []
    most_listened_track_ids = artist_stats_detail.most_listened_track_ids if artist_stats_detail.most_listened_track_ids else []
    most_listened_track_ids_current_month = artist_stats_detail.most_listened_track_ids_current_month if artist_stats_detail.most_listened_track_ids_current_month else []
    return ArtistStatsDetailSchema(
        id=artist_stats_detail.aggregate_id,
        total_detail_page_views=artist_stats_detail.total_detail_page_views,
        total_likes=artist_stats_detail.total_likes,
        most_popular_track_ids=most_popular_track_ids,
        most_listened_track_ids=most_listened_track_ids,
        most_listened_track_ids_current_month=
        most_listened_track_ids_current_month)
