from app.repository.activity_repository import ActivityRepository
from app.repository.artist_repository import (ArtistDetailPageViewRepository,
                                              ArtistLikeRepository,
                                              ArtistStatsRepository)
from datetime import datetime, timezone
from app.schema.activity_schema import MessageResponseSchema
from app.enum.action_type import ActionType
from app.core.logger import Logger
from app.model.activity import Activity
from app.model.artist import (ArtistLike, ArtistDetailPageView)
from app.enum.message_type import MessageType
from app.util.identity_utils import generate_aggregate_id


class ArtistService:

    def __init__(
            self, activity_repository: ActivityRepository,
            artist_detail_page_view_repository: ArtistDetailPageViewRepository,
            artist_like_repository: ArtistLikeRepository,
            artist_stats_repository: ArtistStatsRepository, logger: Logger):
        self.activity_repository = activity_repository
        self.artist_detail_page_view_repository = artist_detail_page_view_repository
        self.artist_like_repository = artist_like_repository
        self.artist_stats_repository = artist_stats_repository
        self.logger = logger

    def handle_like_artist_action(self, activity: Activity) -> None:
        self.activity_repository.save_activity(activity)
        updated_at = datetime.now(timezone.utc)
        artist_like = self.artist_like_repository.find_by_aggregate_id_and_user_id(
            aggregate_id=activity.aggregate_id, user_id=activity.created_by)
        if artist_like:
            artist_like.is_active = True
            artist_like.updated_at = updated_at
            artist_like.updated_by = activity.created_by
        else:
            artist_like = ArtistLike(aggregate_id=activity.aggregate_id,
                                     user_id=activity.created_by,
                                     is_active=True,
                                     created_at=updated_at,
                                     updated_at=updated_at,
                                     created_by=activity.created_by)
        self.artist_like_repository.save_artist_like(artist_like)
        self.logger.info(
            f"Processed {ActionType.LIKE_ARTIST} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )

    def handle_unlike_artist_action(self, activity: Activity) -> None:
        artist_like = self.artist_like_repository.find_by_aggregate_id_and_user_id(
            aggregate_id=activity.aggregate_id, user_id=activity.created_by)
        if artist_like:
            self.activity_repository.save_activity(activity)
            updated_at = datetime.now(timezone.utc)
            artist_like.is_active = False
            artist_like.updated_at = updated_at
            artist_like.updated_by = activity.created_by
            self.artist_like_repository.save_artist_like(artist_like)
            self.logger.info(
                f"Processed {ActionType.UNLIKE_ARTIST} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )

    def handle_view_artist_detail_page_action(
            self, activity: Activity) -> MessageResponseSchema:
        session_id = generate_aggregate_id()
        activity.session_id = session_id
        self.activity_repository.save_activity(activity)
        self.logger.info(
            f"Processed {ActionType.VIEW_ARTIST_DETAIL_PAGE} action: session_id={activity.session_id}, aggregate_id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )
        return MessageResponseSchema(
            id=activity.aggregate_id,
            sessionId=session_id,
            type=MessageType.PROCESSED_VIEW_ARTIST_DETAIL_PAGE_ACTION)

    def handle_viewed_artist_detail_page_action(self, session_id: str) -> None:
        activity: Activity = self.activity_repository.find_by_session_id(
            session_id)
        if activity:
            created_at = datetime.now(timezone.utc)
            duration_second = (created_at - activity.created_at).total_seconds()
            artist_detail_page_view = ArtistDetailPageView(
                session_id=session_id,
                aggregate_id=activity.aggregate_id,
                user_id=activity.created_by,
                is_active=False,
                duration_second=duration_second,
                created_at=created_at,
                created_by=activity.created_by)
            self.artist_detail_page_view_repository.save_artist_detail_page_view(
                artist_detail_page_view)
            self.logger.info(
                f"Processed {ActionType.VIEW_ARTIST_DETAIL_PAGE} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )
