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
from app.model.track import (TrackLike, TrackDetailPageView, TrackListen,
                             TrackStats)
from app.enum.message_type import MessageType
from app.util.identity_utils import generate_aggregate_id
from app.mapper.track_mapper import map_to_track_stats_schema
from app.schema.track_schema import TrackStatsSchema
from app.constant.track_constant import TRACK_LISTEN_MIN_SECOND, TRACK_DETAIL_PAGE_VIEW_MIN_SECOND


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

    async def handle_like_track(self, activity: Activity) -> None:
        updated_at = datetime.now(timezone.utc)
        track_like = self.track_like_repository.find_by_aggregate_id_and_user_id(
            aggregate_id=activity.aggregate_id, user_id=activity.created_by)
        if track_like and track_like.is_active:
            return
        self.activity_repository.save_activity(activity)
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

        track_stats: TrackStats = await self._get_track_stats_by_aggregate_id(
            activity.aggregate_id)
        track_stats.total_likes += 1
        track_stats.updated_at = updated_at
        track_stats.created_by = track_stats.created_by if track_stats.created_by else activity.created_by
        track_stats.updated_by = activity.created_by
        self.track_stats_repository.save_track_stats(track_stats)

        self.logger.info(
            f"Processed {ActionType.LIKE_TRACK} action: id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )

    async def handle_unlike_track(self, activity: Activity) -> None:
        track_like = self.track_like_repository.find_by_aggregate_id_and_user_id(
            aggregate_id=activity.aggregate_id, user_id=activity.created_by)
        if track_like:
            self.activity_repository.save_activity(activity)
            updated_at = datetime.now(timezone.utc)
            track_like.is_active = False
            track_like.updated_at = updated_at
            track_like.updated_by = activity.created_by
            self.track_like_repository.save_track_like(track_like)

            track_stats: TrackStats = await self._get_track_stats_by_aggregate_id(
                activity.aggregate_id)
            track_stats.total_likes -= 1
            track_stats.updated_at = updated_at
            track_stats.created_by = track_stats.created_by if track_stats.created_by else activity.created_by
            track_stats.updated_by = activity.created_by
            self.track_stats_repository.save_track_stats(track_stats)

            self.logger.info(
                f"Processed {ActionType.UNLIKE_TRACK} action: id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )

    async def handle_listen_track_tracking(
            self, activity: Activity) -> dict[str, str]:
        session_id = generate_aggregate_id()
        activity.session_id = session_id
        self.activity_repository.save_activity(activity)
        self.logger.info(
            f"Processed {ActionType.LISTENED_TRACK_TRACKING} action: session_id={activity.session_id}, aggregate_id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )
        return MessageResponseSchema(
            aggregate_id=activity.aggregate_id,
            sessionId=session_id,
            type=MessageType.PROCESSED_LISTEN_TRACK_TRACKING)

    async def handle_listened_track_tracking(self, session_id: str) -> None:
        activity: Activity | None = self.activity_repository.find_by_session_id_and_type(
            session_id, ActionType.LISTEN_TRACK_TRACKING.name)
        if activity:
            updated_at = datetime.now(timezone.utc)
            duration_second = (updated_at - activity.created_at).total_seconds()
            if duration_second >= TRACK_LISTEN_MIN_SECOND:
                track_listen: TrackListen | None = self.track_listen_repository.find_by_session_id(
                    session_id)
                if not track_listen:
                    track_listen = TrackListen(
                        session_id=session_id,
                        aggregate_id=activity.aggregate_id,
                        user_id=activity.created_by,
                        created_at=updated_at,
                        created_by=activity.created_by)

                    track_stats: TrackStats = await self._get_track_stats_by_aggregate_id(
                        activity.aggregate_id)
                    track_stats.total_listens += 1
                    track_stats.updated_at = updated_at
                    track_stats.created_by = track_stats.created_by if track_stats.created_by else activity.created_by
                    track_stats.updated_by = activity.created_by

                    self.track_stats_repository.save_track_stats(track_stats)

                track_listen.duration_second = duration_second
                track_listen.updated_at = updated_at
                track_listen.updated_by = activity.created_by
                self.track_listen_repository.save_track_listen(track_listen)
                self.logger.info(
                    f"Processed {ActionType.LISTENED_TRACK_TRACKING} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
                )

    async def handle_view_track_detail_page_tracking(
            self, activity: Activity) -> MessageResponseSchema:
        session_id = generate_aggregate_id()
        activity.session_id = session_id
        self.activity_repository.save_activity(activity)
        self.logger.info(
            f"Processed {ActionType.VIEW_TRACK_DETAIL_PAGE_TRACKING} action: session_id={activity.session_id}, aggregate_id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )
        return MessageResponseSchema(
            aggregate_id=activity.aggregate_id,
            sessionId=session_id,
            type=MessageType.PROCESSED_VIEW_TRACK_DETAIL_PAGE_TRACKING)

    async def handle_viewed_track_detail_page_tracking(self,
                                                       session_id: str) -> None:
        activity: Activity | None = self.activity_repository.find_by_session_id_and_type(
            session_id, ActionType.VIEW_TRACK_DETAIL_PAGE_TRACKING.name)
        if activity:
            updated_at = datetime.now(timezone.utc)
            duration_second = (updated_at - activity.created_at).total_seconds()
            if duration_second >= TRACK_DETAIL_PAGE_VIEW_MIN_SECOND:
                track_detail_page_view: TrackDetailPageView | None = self.track_detail_page_view_repository.find_by_session_id(
                    session_id)
                if not track_detail_page_view:
                    track_detail_page_view = TrackDetailPageView(
                        session_id=session_id,
                        aggregate_id=activity.aggregate_id,
                        user_id=activity.created_by,
                        created_at=updated_at,
                        created_by=activity.created_by)

                    track_stats: TrackStats = await self._get_track_stats_by_aggregate_id(
                        activity.aggregate_id)
                    track_stats.total_detail_page_views += 1
                    track_stats.updated_at = updated_at
                    track_stats.created_by = track_stats.created_by if track_stats.created_by else activity.created_by
                    track_stats.updated_by = activity.created_by
                    self.track_stats_repository.save_track_stats(track_stats)

                track_detail_page_view.duration_second = duration_second
                track_detail_page_view.updated_at = updated_at
                track_detail_page_view.updated_by = activity.created_by
                self.track_detail_page_view_repository.save_track_detail_page_view(
                    track_detail_page_view)
                self.logger.info(
                    f"Processed {ActionType.VIEWED_TRACK_DETAIL_PAGE_TRACKING} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
                )

    async def get_track_stats(self, aggregate_id: str) -> TrackStatsSchema:
        track_stats = await self._get_track_stats_by_aggregate_id(aggregate_id)
        return map_to_track_stats_schema(track_stats)

    async def get_track_stats_by_ids(self,
                                     aggregate_ids: str) -> TrackStatsSchema:
        return [
            map_to_track_stats_schema(
                await self._get_track_stats_by_aggregate_id(aggregate_id))
            for aggregate_id in aggregate_ids
        ]

    async def _get_track_stats_by_aggregate_id(self, id: str) -> TrackStats:
        track_stats = self.track_stats_repository.find_by_aggregate_id(id)
        if not track_stats:
            created_at = datetime.now(timezone.utc)
            track_stats = TrackStats(aggregate_id=id,
                                     total_detail_page_views=0,
                                     total_likes=0,
                                     total_listens=0,
                                     created_at=created_at,
                                     updated_at=created_at)
        return track_stats
