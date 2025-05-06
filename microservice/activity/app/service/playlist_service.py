from app.repository.activity_repository import ActivityRepository
from datetime import datetime, timezone
from app.core.logger import Logger
from app.model.activity import Activity
from app.schema.activity_schema import ActivitySchema
from app.event.sender.event_sender import send_event
from app.constant.constant import AUTH_SYSTEM_USERNAME
from app.util.identity_utils import generate_aggregate_id
from app.event.schema.playlist_event_schema import (PlaylistCreatedEvent,
                                                    PlaylistUpdatedEvent,
                                                    PlaylistDeletedEvent)
from app.constant.playlist_constant import (PLAYLIST_CREATED_EVENT,
                                            PLAYLIST_UPDATED_EVENT,
                                            PLAYLIST_DELETED_EVENT,
                                            PLAYLIST_URN_PREFIX)
from app.enum.message_type import MessageType
import asyncio


class PlaylistService:

    def __init__(self, activity_repository: ActivityRepository, logger: Logger):
        self.activity_repository = activity_repository
        self.logger = logger

    def handle_create_playlist(self, activity: Activity) -> dict[str, str]:
        aggregate_id = generate_aggregate_id()
        activity.aggregate_id = aggregate_id
        self.activity_repository.save_activity(activity)
        self.logger.info(
            f"Saved Activity: type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )
        playlist_created_event = PlaylistCreatedEvent(
            type=PlaylistCreatedEvent.__name__,
            id=activity.aggregate_id,
            urn=f"{PLAYLIST_URN_PREFIX}{activity.aggregate_id}",
            name=activity.data_json.get("name", "My playlist"),
            track_ids=activity.data_json.get("trackIds", []),
            is_public=activity.data_json.get("isPublic", False),
            thumbnail_url=activity.data_json.get("thumbnailUrl"),
            version=-1,
            created_by=activity.created_by,
            timestamp=activity.created_at)
        asyncio.create_task(
            send_event(topic=PLAYLIST_CREATED_EVENT,
                       event=playlist_created_event,
                       logger=self.logger))
        return {
            "id": activity.aggregate_id,
            "type": MessageType.PROCESSED_CREATE_PLAYLIST_ACTION
        }

    def handle_update_playlist(self, activity: Activity) -> str:
        aggregate_id = activity.aggregate_id
        if self.activity_repository.find_by_aggregate_id(aggregate_id):
            self.activity_repository.save_activity(activity)
            self.logger.info(
                f"Saved Activity: type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )
            playlist_updated_event = PlaylistUpdatedEvent(
                type=PlaylistUpdatedEvent.__name__,
                id=activity.aggregate_id,
                name=activity.data_json.get("name", "My playlist"),
                track_ids=activity.data_json.get("trackIds", []),
                is_public=activity.data_json.get("isPublic", False),
                thumbnail_url=activity.data_json.get("thumbnailUrl"),
                version=-1,
                created_by=activity.created_by,
                timestamp=activity.created_at)
            asyncio.create_task(
                send_event(topic=PLAYLIST_UPDATED_EVENT,
                           event=playlist_updated_event,
                           logger=self.logger))
        return {
            "id": activity.aggregate_id,
            "type": MessageType.PROCESSED_UPDATE_PLAYLIST_ACTION
        }

    def handle_delete_playlist(self, activity: Activity) -> str:
        aggregate_id = activity.aggregate_id
        if self.activity_repository.find_by_aggregate_id(aggregate_id):
            self.activity_repository.save_activity(activity)
            self.logger.info(
                f"Saved Activity: type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )
            playlist_deleted_event = PlaylistDeletedEvent(
                type=PlaylistDeletedEvent.__name__,
                id=activity.aggregate_id,
                is_soft_deleted=False,
                is_active=False,
                version=-1,
                created_by=activity.created_by,
                timestamp=activity.created_at)
            asyncio.create_task(
                send_event(topic=PLAYLIST_DELETED_EVENT,
                           event=playlist_deleted_event,
                           logger=self.logger))
        return {
            "id": activity.aggregate_id,
            "type": MessageType.PROCESSED_DELETE_PLAYLIST_ACTION
        }
