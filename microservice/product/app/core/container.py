from dependency_injector import containers, providers
from app.core.logger import Logger
from app.core.database import Database
from app.core.configuration import configuration
from app.repository.impl.sqlmodel_artist_repository import SqlmodelArtistRepository
from app.repository.impl.sqlmodel_artist_detail_repository import SqlmodelArtistDetailRepository
from app.repository.impl.sqlmodel_track_repository import SqlmodelTrackRepository
from app.repository.impl.sqlmodel_track_detail_repository import SqlmodelTrackDetailRepository
from app.service.artist_service import ArtistService
from app.service.track_service import TrackService
from app.service.search_service import SearchService
from app.event.handler.artist_event_handler import ArtistEventHandler
from app.event.handler.track_event_handler import TrackEventHandler


class Container(containers.DeclarativeContainer):
    wiring_config = containers.WiringConfiguration(modules=[
        "app.router.artist_router", "app.router.track_router",
        "app.router.search_router", "app.event.listener.artist_event_listener",
        "app.event.listener.track_event_listener"
    ])

    logger = providers.Singleton(Logger)
    database = providers.Singleton(
        Database, database_uri=configuration.get_database_uri())

    # Repository
    artist_repository = providers.Factory(
        SqlmodelArtistRepository,
        logger=logger,
        session_factory=database.provided.session)

    artist_detail_repository = providers.Factory(
        SqlmodelArtistDetailRepository,
        logger=logger,
        session_factory=database.provided.session)
    track_repository = providers.Factory(
        SqlmodelTrackRepository,
        logger=logger,
        session_factory=database.provided.session)
    track_detail_repository = providers.Factory(
        SqlmodelTrackDetailRepository,
        logger=logger,
        session_factory=database.provided.session)

    # Service
    artist_service = providers.Factory(
        ArtistService,
        logger=logger,
        artist_detail_repository=artist_detail_repository)
    track_service = providers.Factory(
        TrackService,
        logger=logger,
        track_detail_repository=track_detail_repository)
    search_service = providers.Factory(
        SearchService,
        logger=logger,
        artist_detail_repository=artist_detail_repository,
    )

    # Event Handler
    artist_event_handler = providers.Factory(
        ArtistEventHandler, artist_repository=artist_repository, logger=logger)
    track_event_handler = providers.Factory(TrackEventHandler,
                                            track_repository=track_repository,
                                            logger=logger)
