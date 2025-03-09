from dependency_injector import containers, providers
from app.core.logger import Logger
from app.core.database import Database
from app.core.configuration import configuration
from app.repository.artist_repository import ArtistRepository
from app.service.artist_service import ArtistService


class Container(containers.DeclarativeContainer):
    wiring_config = containers.WiringConfiguration(modules=[
        "app.router.artist_router", "app.event.consumer.artist_event_consumer"
    ])

    logger = providers.Singleton(Logger)
    database = providers.Singleton(
        Database, database_uri=configuration.get_database_uri())

    # Repository
    artist_repository = providers.Factory(
        ArtistRepository, session_factory=database.provided.session)

    # Service
    artist_service = providers.Factory(ArtistService,
                                       artist_repository=artist_repository,
                                       logger=logger)
