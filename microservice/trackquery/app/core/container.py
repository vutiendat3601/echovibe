from dependency_injector import containers, providers
from app.core.logger import Logger
from app.core.database import Database
from app.core.configuration import configuration
from app.repository.impl.sqlmodel_artist_repository import SqlmodelArtistRepository
from app.service.artist_service import ArtistService
from app.event.handler.artist_event_handler import ArtistEventHandler


class Container(containers.DeclarativeContainer):
    wiring_config = containers.WiringConfiguration(modules=[
        "app.router.artist_router",
        "app.event.listener.artist_event_listener"
    ])

    logger = providers.Singleton(Logger)
    database = providers.Singleton(
        Database, database_uri=configuration.get_database_uri())

    # Repository
    artist_repository = providers.Factory(
        SqlmodelArtistRepository,
        logger=logger,
        session_factory=database.provided.session)

    # Service
    artist_service = providers.Factory(ArtistService,
                                       artist_repository=artist_repository,
                                       logger=logger)

    # Event Handler
    artist_event_handler = providers.Factory(
        ArtistEventHandler, artist_repository=artist_repository, logger=logger)
