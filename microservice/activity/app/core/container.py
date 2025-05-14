from dependency_injector import containers, providers
from app.core.logger import Logger
from app.core.database import Database
from app.core.configuration import configuration
from app.repository.impl.sqlmodel_activity_repository import SqlmodelActivityRepository
from app.service.activity_service import ActivityService
from app.service.playlist_service import PlaylistService
from app.service.artist_service import ArtistService
from app.service.track_service import TrackService
from app.service.user_service import UserService
from app.repository.impl.sqlmodel_artist_repository import (
    SqlmodelArtistDetailPageViewRepository, SqlmodelArtistLikeRepository,
    SqlmodelArtistStatsRepository, SqlmodelArtistRecommendationRepository,
    SqlmodelArtistStatsDetailRepository, SqlmodelArtistReportRepository)
from app.repository.impl.sqlmodel_track_repository import (
    SqlmodelTrackDetailPageViewRepository, SqlmodelTrackLikeRepository,
    SqlmodelTrackListenRepository, SqlmodelTrackStatsRepository,
    SqlmodelTrackReportRepository)
from app.repository.impl.sqlmodel_user_repository import (
    SqlmodelUserDataRepository, SqlmodelUserUsageDataRepository,
    SqlmodelUserPlaylistRepository, SqlmodelUserTrackRatingRepository,
    SqlmodelUserTrackRecommendationRepository)
from app.client.product_client import ProductClient


class Container(containers.DeclarativeContainer):
    wiring_config = containers.WiringConfiguration(modules=[
        "app.router.activity_router", "app.router.track_router",
        "app.router.user_router", "app.router.artist_router",
        "app.router.job_router"
    ])

    logger = providers.Singleton(Logger)
    database = providers.Singleton(
        Database, database_uri=configuration.get_database_uri())

    # Client
    product_client = providers.Singleton(
        ProductClient, base_url=configuration.get_product_base_url())

    # Repository
    activity_repository = providers.Factory(
        SqlmodelActivityRepository,
        logger=logger,
        session_factory=database.provided.session)
    artist_detail_page_view_repository = providers.Factory(
        SqlmodelArtistDetailPageViewRepository,
        logger=logger,
        session_factory=database.provided.session)
    artist_like_repository = providers.Factory(
        SqlmodelArtistLikeRepository,
        logger=logger,
        session_factory=database.provided.session)
    artist_stats_repository = providers.Factory(
        SqlmodelArtistStatsRepository,
        logger=logger,
        session_factory=database.provided.session)
    artist_recommendation_repository = providers.Factory(
        SqlmodelArtistRecommendationRepository,
        logger=logger,
        session_factory=database.provided.session)
    artist_stats_detail_repository = providers.Factory(
        SqlmodelArtistStatsDetailRepository,
        logger=logger,
        session_factory=database.provided.session)
    artist_report_repository = providers.Factory(
        SqlmodelArtistReportRepository,
        logger=logger,
        session_factory=database.provided.session)

    track_detail_page_view_repository = providers.Factory(
        SqlmodelTrackDetailPageViewRepository,
        logger=logger,
        session_factory=database.provided.session)
    track_like_repository = providers.Factory(
        SqlmodelTrackLikeRepository,
        logger=logger,
        session_factory=database.provided.session)
    track_listen_repository = providers.Factory(
        SqlmodelTrackListenRepository,
        logger=logger,
        session_factory=database.provided.session)
    track_stats_repository = providers.Factory(
        SqlmodelTrackStatsRepository,
        logger=logger,
        session_factory=database.provided.session)
    track_report_repository = providers.Factory(
        SqlmodelTrackReportRepository,
        logger=logger,
        session_factory=database.provided.session)

    user_data_repository = providers.Factory(
        SqlmodelUserDataRepository,
        logger=logger,
        session_factory=database.provided.session)
    user_usage_data_repository = providers.Factory(
        SqlmodelUserUsageDataRepository,
        logger=logger,
        session_factory=database.provided.session)
    user_playlist_repository = providers.Factory(
        SqlmodelUserPlaylistRepository,
        logger=logger,
        session_factory=database.provided.session)
    user_track_rating_repository = providers.Factory(
        SqlmodelUserTrackRatingRepository,
        logger=logger,
        session_factory=database.provided.session)
    user_track_recommendation_repository = providers.Factory(
        SqlmodelUserTrackRecommendationRepository,
        logger=logger,
        session_factory=database.provided.session)

    # Service
    playlist_service = providers.Factory(
        PlaylistService,
        activity_repository=activity_repository,
        user_playlist_repository=user_playlist_repository,
        logger=logger)
    artist_service = providers.Factory(
        ArtistService,
        activity_repository=activity_repository,
        artist_detail_page_view_repository=artist_detail_page_view_repository,
        artist_like_repository=artist_like_repository,
        artist_stats_repository=artist_stats_repository,
        artist_recommendation_repository=artist_recommendation_repository,
        artist_stats_detail_repository=artist_stats_detail_repository,
        product_client=product_client,
        artist_report_repository=artist_report_repository,
        track_report_repository=track_report_repository,
        logger=logger)
    track_service = providers.Factory(
        TrackService,
        activity_repository=activity_repository,
        track_detail_page_view_repository=track_detail_page_view_repository,
        track_like_repository=track_like_repository,
        track_listen_repository=track_listen_repository,
        track_stats_repository=track_stats_repository,
        logger=logger)
    user_service = providers.Factory(
        UserService,
        activity_repository=activity_repository,
        user_data_repository=user_data_repository,
        user_usage_data_repository=user_usage_data_repository,
        user_track_rating_repository=user_track_rating_repository,
        user_track_recommendation_repository=
        user_track_recommendation_repository,
        track_report_repository=track_report_repository,
        logger=logger)

    activity_service = providers.Factory(ActivityService,
                                         playlist_service=playlist_service,
                                         artist_service=artist_service,
                                         track_service=track_service,
                                         logger=logger)
