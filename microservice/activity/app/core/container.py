from dependency_injector import containers, providers
from app.core.logger import Logger
from app.core.database import Database
from app.core.configuration import configuration
from app.repository.impl.sqlmodel_activity_repository import SqlmodelActivityRepository


class Container(containers.DeclarativeContainer):
    wiring_config = containers.WiringConfiguration(
        modules=["app.router.activity_router"])

    logger = providers.Singleton(Logger)
    database = providers.Singleton(
        Database, database_uri=configuration.get_database_uri())

    # Repository
    activity_repository = providers.Factory(
        SqlmodelActivityRepository,
        logger=logger,
        session_factory=database.provided.session)

    # Service
