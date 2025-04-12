from dependency_injector import containers, providers
from app.core.logger import Logger
from app.core.database import Database
from app.core.configuration import configuration
from app.repository.impl.sqlmodel_track_repository import SqlmodelTrackRepository
from app.service.track_service import TrackService
from app.event.handler.track_event_handler import TrackEventHandler


class Container(containers.DeclarativeContainer):
    wiring_config = containers.WiringConfiguration(modules=[
        "app.router.track_router", "app.event.listener.track_event_listener"
    ])

    logger = providers.Singleton(Logger)
    database = providers.Singleton(
        Database, database_uri=configuration.get_database_uri())

    # Repository
    track_repository = providers.Factory(
        SqlmodelTrackRepository,
        logger=logger,
        session_factory=database.provided.session)

    # Service
    track_service = providers.Factory(TrackService,
                                      track_repository=track_repository,
                                      logger=logger)

    # Event Handler
    track_event_handler = providers.Factory(TrackEventHandler,
                                            track_repository=track_repository,
                                            logger=logger)
