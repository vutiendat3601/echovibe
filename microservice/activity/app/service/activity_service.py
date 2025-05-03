from app.repository.activity_repository import ActivityRepository
from datetime import datetime, timezone
from app.core.logger import Logger
from app.model.activity import Activity
from app.schema.activity_schema import CreateActivitySchema
from app.event.sender.event_sender import send_event
from app.constant.constant import AUTH_SYSTEM_USERNAME
from app.util.identity_utils import generate_aggregate_id
from app.enum.action_type import ActionType
from app.event.schema.playlist_event_schema import PlaylistCreatedEvent
from app.constant.playlist_constant import (PLAYLIST_CREATED_EVENT,
                                            PLAYLIST_URN_PREFIX)
import asyncio


class ActivityService:

    def __init__(self, activity_repository: ActivityRepository, logger: Logger):
        self.activity_repository = activity_repository
        self.logger = logger

    def handle_activity(self,
                        create_activity: CreateActivitySchema,
                        jwt_claims: dict = {}) -> str | None:
        created_at = datetime.now(timezone.utc)
        activity: Activity = Activity(
            description=None,
            type=create_activity.type,
            data_json=create_activity.data_json,
            created_at=created_at,
            created_by=jwt_claims.get("sub")
            if jwt_claims and jwt_claims.get("sub") else AUTH_SYSTEM_USERNAME,
        )

        if activity.type == ActionType.CREATE_PLAYLIST:
            return self._handle_create_playlist(activity)

    def _handle_create_playlist(self, activity: Activity) -> str:
        aggregate_id = generate_aggregate_id()
        activity.aggregate_id = aggregate_id
        self.activity_repository.save_activity(activity)
        self.logger.info(
            f"Saved Activity: type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )
        asyncio.create_task(
            send_event(topic=PLAYLIST_CREATED_EVENT,
                       event=PlaylistCreatedEvent(
                           id=activity.aggregate_id,
                           urn=f"{PLAYLIST_URN_PREFIX}{activity.aggregate_id}",
                           track_ids=activity.data_json.get("trackIds", []),
                           type=PlaylistCreatedEvent.__name__,
                           version=0,
                           created_by=activity.created_by,
                           timestamp=activity.created_at),
                       logger=self.logger))
        return activity.aggregate_id
