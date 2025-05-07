from app.model.user import UserUsageData
from app.schema.user_schema import UserUsageDataSchema


def map_to_user_usage_data_schema(user_usage_data: UserUsageData):
    liked_track_ids = user_usage_data.liked_track_ids if user_usage_data.liked_track_ids else []
    liked_artist_ids = user_usage_data.liked_artist_ids if user_usage_data.liked_artist_ids else []
    created_playlist_ids = user_usage_data.created_playlist_ids if user_usage_data.created_playlist_ids else []

    return UserUsageDataSchema(user_id=user_usage_data.user_id,
                               data=user_usage_data.data_json,
                               updated_at=user_usage_data.updated_at,
                               liked_track_ids=liked_track_ids,
                               liked_artist_ids=liked_artist_ids,
                               created_playlist_ids=created_playlist_ids)
