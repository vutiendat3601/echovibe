from app.repository.activity_repository import ActivityRepository
from app.repository.track_repository import (TrackDetailPageViewRepository,
                                             TrackLikeRepository,
                                             TrackListenRepository,
                                             TrackStatsRepository)
from datetime import datetime, timezone
from app.schema.activity_schema import MessageResponseSchema
from app.enum.action_type import ActionType
from app.core.logger import Logger
from app.model.activity import Activity
from app.enum.action_type import ActionType
from app.model.track import (TrackLike, TrackDetailPageView, TrackListen)
from app.enum.message_type import MessageType
from app.util.identity_utils import generate_aggregate_id


class TrackService:

    def __init__(
            self, activity_repository: ActivityRepository,
            track_detail_page_view_repository: TrackDetailPageViewRepository,
            track_like_repository: TrackLikeRepository,
            track_listen_repository: TrackListenRepository,
            track_stats_repository: TrackStatsRepository, logger: Logger):
        self.activity_repository = activity_repository
        self.track_detail_page_view_repository = track_detail_page_view_repository
        self.track_like_repository = track_like_repository
        self.track_listen_repository = track_listen_repository
        self.track_stats_repository = track_stats_repository
        self.logger = logger

    def handle_like_track(self, activity: Activity) -> None:
        self.activity_repository.save_activity(activity)
        updated_at = datetime.now(timezone.utc)
        track_like = self.track_like_repository.find_by_aggregate_id_and_user_id(
            aggregate_id=activity.aggregate_id, user_id=activity.created_by)
        if track_like:
            track_like.is_active = True
            track_like.updated_at = updated_at
            track_like.updated_by = activity.created_by
        else:
            track_like = TrackLike(aggregate_id=activity.aggregate_id,
                                   user_id=activity.created_by,
                                   is_active=True,
                                   created_at=updated_at,
                                   updated_at=updated_at,
                                   created_by=activity.created_by)
        self.track_like_repository.save_track_like(track_like)
        self.logger.info(
            f"Processed {ActionType.LIKE_TRACK} action: id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )

    def handle_unlike_track(self, activity: Activity) -> None:
        track_like = self.track_like_repository.find_by_aggregate_id_and_user_id(
            aggregate_id=activity.aggregate_id, user_id=activity.created_by)
        if track_like:
            self.activity_repository.save_activity(activity)
            updated_at = datetime.now(timezone.utc)
            track_like.is_active = False
            track_like.updated_at = updated_at
            track_like.updated_by = activity.created_by
            self.track_like_repository.save_track_like(track_like)
            self.logger.info(
                f"Processed {ActionType.UNLIKE_TRACK} action: id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )

    def handle_listen_track_tracking(self, activity: Activity) -> dict[str, str]:
        session_id = generate_aggregate_id()
        activity.session_id = session_id
        self.activity_repository.save_activity(activity)
        self.logger.info(
            f"Processed {ActionType.LISTENED_TRACK_TRACKING} action: session_id={activity.session_id}, aggregate_id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )
        return MessageResponseSchema(
            id=activity.aggregate_id,
            sessionId=session_id,
            type=MessageType.PROCESSED_LISTEN_TRACK_TRACKING)

    def handle_listened_track_tracking(self, session_id: str) -> None:
        activity: Activity | None = self.activity_repository.find_by_session_id_and_type(
            session_id, ActionType.LISTEN_TRACK_TRACKING.name)
        if activity:
            created_at = datetime.now(timezone.utc)
            duration_second = (created_at - activity.created_at).total_seconds()
            track_listen = TrackListen(session_id=session_id,
                                       aggregate_id=activity.aggregate_id,
                                       user_id=activity.created_by,
                                       is_active=False,
                                       duration_second=duration_second,
                                       created_at=created_at,
                                       created_by=activity.created_by)
            self.track_listen_repository.save_track_listen(track_listen)
            self.logger.info(
                f"Processed {ActionType.LISTENED_TRACK_TRACKING} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )

    def handle_view_track_detail_page_tracking(
            self, activity: Activity) -> MessageResponseSchema:
        session_id = generate_aggregate_id()
        activity.session_id = session_id
        self.activity_repository.save_activity(activity)
        self.logger.info(
            f"Processed {ActionType.VIEW_TRACK_DETAIL_PAGE_TRACKING} action: session_id={activity.session_id}, aggregate_id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )
        return MessageResponseSchema(
            id=activity.aggregate_id,
            sessionId=session_id,
            type=MessageType.PROCESSED_VIEW_TRACK_DETAIL_PAGE_TRACKING)

    def handle_viewed_track_detail_page_tracking(self, session_id: str) -> None:
        activity: Activity | None = self.activity_repository.find_by_session_id_and_type(
            session_id, ActionType.VIEW_TRACK_DETAIL_PAGE_TRACKING.name)
        if activity:
            created_at = datetime.now(timezone.utc)
            duration_second = (created_at - activity.created_at).total_seconds()
            track_detail_page_view = TrackDetailPageView(
                session_id=session_id,
                aggregate_id=activity.aggregate_id,
                user_id=activity.created_by,
                is_active=False,
                duration_second=duration_second,
                created_at=created_at,
                created_by=activity.created_by)
            self.track_detail_page_view_repository.save_track_detail_page_view(
                track_detail_page_view)
            self.logger.info(
                f"Processed {ActionType.VIEWED_TRACK_DETAIL_PAGE_TRACKING} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )
