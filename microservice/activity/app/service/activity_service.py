from app.repository.activity_repository import ActivityRepository
from datetime import datetime, timezone
from app.core.logger import Logger
from app.model.activity import Activity
from app.schema.activity_schema import ActivitySchema
from app.constant.constant import AUTH_SYSTEM_USERNAME
from app.enum.action_type import ActionType

from app.service.artist_service import ArtistService
from app.service.playlist_service import PlaylistService
from app.service.track_service import TrackService


class ActivityService:

    def __init__(self, playlist_service: PlaylistService,
                 artist_service: ArtistService, track_service: TrackService,
                 logger: Logger):
        self.playlist_service = playlist_service
        self.artist_service = artist_service
        self.track_service = track_service
        self.logger = logger

    def handle_activity(self,
                        activity_schema: ActivitySchema,
                        jwt_claims: dict = {}) -> dict[str, str]:
        created_at = datetime.now(timezone.utc)
        activity: Activity = Activity(
            session_id=activity_schema.session_id,
            aggregate_id=activity_schema.aggregate_id,
            description=None,
            type=activity_schema.type,
            data_json=activity_schema.data_json,
            created_at=created_at,
            created_by=jwt_claims.get("sub")
            if jwt_claims and jwt_claims.get("sub") else AUTH_SYSTEM_USERNAME,
        )

        # Playlist action handlers
        if activity.type == ActionType.CREATE_PLAYLIST:
            return self.playlist_service.handle_create_playlist(activity)

        elif activity.type == ActionType.UPDATE_PLAYLIST:
            return self.playlist_service.handle_update_playlist(activity)

        elif activity.type == ActionType.DELETE_PLAYLIST:
            return self.playlist_service.handle_delete_playlist(activity)

        # Artist action handlers
        elif activity.type == ActionType.LIKE_ARTIST:
            return self.artist_service.handle_like_artist_action(activity)

        elif activity.type == ActionType.UNLIKE_ARTIST:
            return self.artist_service.handle_unlike_artist_action(activity)

        elif activity.type == ActionType.VIEW_ARTIST_DETAIL_PAGE:
            return self.artist_service.handle_view_artist_detail_page_action(
                activity)

        elif activity.type == ActionType.VIEWED_ARTIST_DETAIL_PAGE:
            return self.artist_service.handle_viewed_artist_detail_page_action(
                activity.session_id)

        # Track action handlers
        elif activity.type == ActionType.LIKE_TRACK:
            return self.track_service.handle_like_track_action(activity)

        elif activity.type == ActionType.UNLIKE_TRACK:
            return self.track_service.handle_unlike_track_action(activity)

        elif activity.type == ActionType.LISTEN_TRACK:
            return self.track_service.handle_listen_track_action(activity)

        elif activity.type == ActionType.LISTENED_TRACK:
            return self.track_service.handle_listened_track_action(
                activity.session_id)

        elif activity.type == ActionType.VIEW_TRACK_DETAIL_PAGE:
            return self.track_service.handle_view_track_detail_page_action(
                activity)

        elif activity.type == ActionType.VIEWED_TRACK_DETAIL_PAGE:
            return self.track_service.handle_viewed_track_detail_page_action(
                activity.session_id)

        else:
            self.logger.error(
                f"Unsupported activity type: {activity.type}. Activity not saved."
            )
            return None
