from app.model.artist import ArtistStats
from app.schema.artist_schema import ArtistStatsSchema


def map_to_artist_stats_schema(artist_stats: ArtistStats) -> ArtistStatsSchema:

    return ArtistStatsSchema(
        id=artist_stats.aggregate_id,
        total_detail_page_views=artist_stats.total_detail_page_views,
        total_likes=artist_stats.total_likes)
