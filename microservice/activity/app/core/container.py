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
    SqlmodelArtistStatsRepository)
from app.repository.impl.sqlmodel_track_repository import (
    SqlmodelTrackDetailPageViewRepository, SqlmodelTrackLikeRepository,
    SqlmodelTrackListenRepository, SqlmodelTrackStatsRepository)
from app.repository.impl.sqlmodel_user_repository import (
    SqlmodelUserDataRepository, SqlmodelUserUsageDataRepository)


class Container(containers.DeclarativeContainer):
    wiring_config = containers.WiringConfiguration(
        modules=["app.router.activity_router", "app.router.user_router"])

    logger = providers.Singleton(Logger)
    database = providers.Singleton(
        Database, database_uri=configuration.get_database_uri())

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
    user_data_repository = providers.Factory(
        SqlmodelUserDataRepository,
        logger=logger,
        session_factory=database.provided.session)
    user_usage_data_repository = providers.Factory(
        SqlmodelUserUsageDataRepository,
        logger=logger,
        session_factory=database.provided.session)

    # Service
    playlist_service = providers.Factory(
        PlaylistService, activity_repository=activity_repository, logger=logger)
    artist_service = providers.Factory(
        ArtistService,
        activity_repository=activity_repository,
        artist_detail_page_view_repository=artist_detail_page_view_repository,
        artist_like_repository=artist_like_repository,
        artist_stats_repository=artist_stats_repository,
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
        logger=logger)

    activity_service = providers.Factory(ActivityService,
                                         playlist_service=playlist_service,
                                         artist_service=artist_service,
                                         track_service=track_service,
                                         logger=logger)
