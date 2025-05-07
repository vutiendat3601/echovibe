from app.repository.activity_repository import ActivityRepository
from app.core.logger import Logger
from datetime import datetime, timezone
from app.model.activity import Activity
from app.model.user import UserPlaylist
from app.event.sender.event_sender import send_event
from app.enum.message_type import MessageType
from app.schema.activity_schema import MessageResponseSchema
from app.util.identity_utils import generate_aggregate_id
from app.event.schema.playlist_event_schema import (PlaylistCreatedEvent,
                                                    PlaylistUpdatedEvent,
                                                    PlaylistDeletedEvent)
from app.constant.playlist_constant import (PLAYLIST_CREATED_EVENT,
                                            PLAYLIST_UPDATED_EVENT,
                                            PLAYLIST_DELETED_EVENT,
                                            PLAYLIST_URN_PREFIX)
from app.repository.user_repository import UserPlaylistRepository

import asyncio


class PlaylistService:

    def __init__(self, activity_repository: ActivityRepository,
                 user_playlist_repository: UserPlaylistRepository,
                 logger: Logger):
        self.activity_repository = activity_repository
        self.user_playlist_repository = user_playlist_repository
        self.logger = logger

    def handle_create_playlist(self,
                               activity: Activity) -> MessageResponseSchema:
        aggregate_id = generate_aggregate_id()
        created_at = datetime.now(timezone.utc)
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
        user_playlist = UserPlaylist(playlist_id=aggregate_id,
                                     user_id=activity.created_by,
                                     is_active=True,
                                     created_at=created_at,
                                     updated_at=created_at,
                                     created_by=activity.created_by,
                                     updated_by=activity.created_by)
        self.user_playlist_repository.save_user_playlist(user_playlist)
        return MessageResponseSchema(aggregate_id=activity.aggregate_id,
                                     type=MessageType.PROCESSED_CREATE_PLAYLIST)

    def handle_update_playlist(self,
                               activity: Activity) -> MessageResponseSchema:
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
        return MessageResponseSchema(aggregate_id=activity.aggregate_id,
                                     type=MessageType.PROCESSED_UPDATE_PLAYLIST)

    def handle_delete_playlist(self,
                               activity: Activity) -> MessageResponseSchema:
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
        return MessageResponseSchema(aggregate_id=activity.aggregate_id,
                                     type=MessageType.PROCESSED_DELETE_PLAYLIST)
