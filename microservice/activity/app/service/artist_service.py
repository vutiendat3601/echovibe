from app.repository.activity_repository import ActivityRepository
from app.repository.artist_repository import (ArtistDetailPageViewRepository,
                                              ArtistLikeRepository,
                                              ArtistStatsRepository,
                                              ArtistRecommendationRepository,
                                              ArtistStatsDetailRepository)
from datetime import datetime, timezone
from app.schema.activity_schema import MessageResponseSchema
from app.enum.action_type import ActionType
from app.core.logger import Logger
from app.model.activity import Activity
from app.model.artist import (ArtistLike, ArtistDetailPageView, ArtistStats,
                              ArtistStatsDetail, ArtistRecommendation)
from app.schema.track_schema import TrackDetailSchema
from app.enum.message_type import MessageType
from app.util.identity_utils import generate_aggregate_id
from app.mapper.artist_mapper import map_to_artist_stats_detail_schema
from app.schema.artist_schema import ArtistStatsDetailSchema
from app.client.product_client import ProductClient
from app.constant.artist_constant import ARTIST_DETAIL_PAGE_VIEW_MIN_SECOND
import asyncio
from app.constant.constant import AUTH_SYSTEM_USERNAME


class ArtistService:

    def __init__(
            self, activity_repository: ActivityRepository,
            artist_detail_page_view_repository: ArtistDetailPageViewRepository,
            artist_like_repository: ArtistLikeRepository,
            artist_stats_repository: ArtistStatsRepository,
            artist_recommendation_repository: ArtistRecommendationRepository,
            artist_stats_detail_repository: ArtistStatsDetailRepository,
            product_client: ProductClient, logger: Logger):
        self.activity_repository = activity_repository
        self.artist_detail_page_view_repository = artist_detail_page_view_repository
        self.artist_like_repository = artist_like_repository
        self.artist_stats_repository = artist_stats_repository
        self.artist_recommendation_repository = artist_recommendation_repository
        self.artist_stats_detail_repository = artist_stats_detail_repository
        self.product_client = product_client
        self.logger = logger

    async def handle_like_artist(self, activity: Activity) -> None:
        updated_at = datetime.now(timezone.utc)
        artist_like = self.artist_like_repository.find_by_aggregate_id_and_user_id(
            aggregate_id=activity.aggregate_id, user_id=activity.created_by)
        if artist_like and artist_like.is_active:
            return
        self.activity_repository.save_activity(activity)
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

        artist_stats: ArtistStats = await self._get_artist_stats_by_id(
            activity.aggregate_id)
        artist_stats.total_likes += 1
        artist_stats.updated_at = updated_at
        artist_stats.created_by = artist_stats.created_by if artist_stats.created_by else activity.created_by
        artist_stats.updated_by = activity.created_by
        self.artist_stats_repository.save_artist_stats(artist_stats)

        self.logger.info(
            f"Processed {ActionType.LIKE_ARTIST} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )

    async def handle_unlike_artist(self, activity: Activity) -> None:
        artist_like = self.artist_like_repository.find_by_aggregate_id_and_user_id(
            aggregate_id=activity.aggregate_id, user_id=activity.created_by)
        if artist_like:
            self.activity_repository.save_activity(activity)
            updated_at = datetime.now(timezone.utc)
            artist_like.is_active = False
            artist_like.updated_at = updated_at
            artist_like.updated_by = activity.created_by
            self.artist_like_repository.save_artist_like(artist_like)

            artist_stats: ArtistStats = await self._get_artist_stats_by_id(
                activity.aggregate_id)
            artist_stats.total_likes -= 1
            artist_stats.updated_at = updated_at
            artist_stats.created_by = artist_stats.created_by if artist_stats.created_by else activity.created_by
            artist_stats.updated_by = activity.created_by
            self.artist_stats_repository.save_artist_stats(artist_stats)

            self.logger.info(
                f"Processed {ActionType.UNLIKE_ARTIST} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )

    async def handle_view_artist_detail_page_tracking(
            self, activity: Activity) -> MessageResponseSchema:
        session_id = generate_aggregate_id()
        activity.session_id = session_id
        self.activity_repository.save_activity(activity)
        self.logger.info(
            f"Processed {ActionType.VIEW_ARTIST_DETAIL_PAGE_TRACKING} action: session_id={activity.session_id}, aggregate_id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
        )
        return MessageResponseSchema(
            aggregate_id=activity.aggregate_id,
            sessionId=session_id,
            type=MessageType.PROCESSED_VIEW_ARTIST_DETAIL_PAGE_TRACKING)

    async def handle_viewed_artist_detail_page_tracking(
            self, session_id: str) -> None:
        activity: Activity = self.activity_repository.find_by_session_id_and_type(
            session_id, ActionType.VIEW_ARTIST_DETAIL_PAGE_TRACKING.name)
        if activity:
            updated_at = datetime.now(timezone.utc)
            duration_second = (updated_at - activity.created_at).total_seconds()
            if duration_second >= ARTIST_DETAIL_PAGE_VIEW_MIN_SECOND:
                artist_detail_page_view: ArtistDetailPageView | None = self.artist_detail_page_view_repository.find_by_session_id(
                    session_id)
                if not artist_detail_page_view:
                    artist_detail_page_view = ArtistDetailPageView(
                        session_id=session_id,
                        aggregate_id=activity.aggregate_id,
                        user_id=activity.created_by,
                        created_at=updated_at,
                        created_by=activity.created_by)

                    artist_stats: ArtistStats = await self._get_artist_stats_by_id(
                        activity.aggregate_id)
                    artist_stats.total_detail_page_views += 1
                    artist_stats.updated_at = updated_at
                    artist_stats.created_by = artist_stats.created_by if artist_stats.created_by else activity.created_by
                    artist_stats.updated_by = activity.created_by
                    self.artist_stats_repository.save_artist_stats(artist_stats)
                    
                artist_detail_page_view.duration_second = duration_second
                artist_detail_page_view.updated_at = updated_at
                artist_detail_page_view.updated_by = activity.created_by
                self.artist_detail_page_view_repository.save_artist_detail_page_view(
                    artist_detail_page_view)

            self.logger.info(
                f"Processed {ActionType.VIEW_ARTIST_DETAIL_PAGE_TRACKING} action: session_id={activity.session_id}, id={activity.aggregate_id}, type={activity.type}, created_by={activity.created_by}, created_at={activity.created_at}"
            )

    async def get_artist_stats_detail(
            self,
            aggregate_id: str,
            jwt: str | None = None) -> ArtistStatsDetailSchema:
        artist_stats_detail = self.artist_stats_detail_repository.find_by_aggregate_id(
            aggregate_id)
        if not artist_stats_detail:
            return await self._fallback_get_artist_stats_detail(
                aggregate_id, jwt)
        if not artist_stats_detail.artist_recommendation_id:
            asyncio.create_task(
                self._process_artist_recommendation(aggregate_id))
        return map_to_artist_stats_detail_schema(artist_stats_detail)

    async def _fallback_get_artist_stats_detail(
            self,
            aggregate_id: str,
            jwt: str | None = None) -> ArtistStatsDetailSchema:
        await self._process_artist_recommendation(aggregate_id, jwt)
        created_at = datetime.now(timezone.utc)
        artist_stats = ArtistStats(aggregate_id=aggregate_id,
                                   total_detail_page_views=0,
                                   total_likes=0,
                                   created_at=created_at,
                                   updated_at=created_at,
                                   created_by=AUTH_SYSTEM_USERNAME,
                                   updated_by=AUTH_SYSTEM_USERNAME)
        self.artist_stats_repository.save_artist_stats(artist_stats)
        artist_stats_detail = self.artist_stats_detail_repository.find_by_aggregate_id(
            aggregate_id)
        return map_to_artist_stats_detail_schema(artist_stats_detail)

    async def _process_artist_recommendation(self,
                                             aggregate_id: str,
                                             jwt: str | None = None) -> None:
        artist_recommendation = self.artist_recommendation_repository.find_by_aggregate_id(
            aggregate_id)
        if not artist_recommendation:
            created_at = datetime.now(timezone.utc)
            artist_recommendation = ArtistRecommendation(
                aggregate_id=aggregate_id,
                most_listened_track_ids=[],
                most_listened_track_ids_current_month=[],
                most_popular_track_ids=[],
                created_at=created_at,
                updated_at=created_at,
                created_by=AUTH_SYSTEM_USERNAME,
                updated_by=AUTH_SYSTEM_USERNAME)
        try:
            if jwt:
                tracks: list[
                    TrackDetailSchema] = await self.product_client.get_all_tracks_by_artist_id(
                        aggregate_id, jwt)
                track_ids = [track.id for track in tracks]
                artist_recommendation.most_listened_track_ids = track_ids
                artist_recommendation.most_listened_track_ids_current_month = track_ids
                artist_recommendation.most_popular_track_ids = track_ids
        except Exception as e:
            self.logger.error(
                f"Error occurred while fetching tracks for artist {aggregate_id}: {e}"
            )
        self.artist_recommendation_repository.save_artist_recommendation(
            artist_recommendation)

    async def _get_artist_stats_by_id(self, aggregate_id: str) -> ArtistStats:
        artist_stats = self.artist_stats_repository.find_by_aggregate_id(
            aggregate_id)
        if not artist_stats:
            created_at = datetime.now(timezone.utc)
            artist_stats = ArtistStats(aggregate_id=aggregate_id,
                                       total_detail_page_views=0,
                                       total_likes=0,
                                       created_at=created_at,
                                       updated_at=created_at)
        return artist_stats
