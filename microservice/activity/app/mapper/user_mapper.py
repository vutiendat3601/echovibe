from app.model.user import UserStats
from app.schema.user_schema import UserStatsSchema


def map_to_user_stats_schema(user_stats: UserStats):
    liked_track_ids = user_stats.liked_track_ids if user_stats.liked_track_ids else []
    liked_artist_ids = user_stats.liked_artist_ids if user_stats.liked_artist_ids else []
    return UserStatsSchema(user_id=user_stats.user_id,
                           data=user_stats.data_json,
                           updated_at=user_stats.updated_at,
                           liked_track_ids=liked_track_ids,
                           liked_artist_ids=liked_artist_ids)
