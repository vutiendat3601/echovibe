from contextlib import asynccontextmanager
from typing import AsyncGenerator
from pathlib import Path
import asyncio
from fastapi import FastAPI
from app.util.dependency_util import singleton
from app.router.router import apiRouter
from app.core.container import Container
from app.event.consumer.artist_event_consumer import listen_artist_created_event, listen_artist_published_event, listen_artist_updated_event, listen_artist_deleted_event
from app.core.configuration import configuration
from app.constant.constant import APP_NAME

banner = Path("banner.txt").read_text()

CONSUMER_LISTENERS = [
    listen_artist_created_event, listen_artist_published_event,
    listen_artist_updated_event, listen_artist_deleted_event
]


@singleton
class AppInitializer:

    def __init__(self):

        @asynccontextmanager
        async def lifespan(_: FastAPI) -> AsyncGenerator[None, None]:
            self.logger.info("Starting Kafka consumers...")
            consumer_tasks = []
            for consumer_listener in CONSUMER_LISTENERS:
                consumer_tasks.append(asyncio.create_task(consumer_listener()))
            yield
            self.logger.info("Shutting down Kafka consumers...")
            for consumer_task in consumer_tasks:
                consumer_task.cancel()
            self.logger.info("All Kafka consumers stopped.")

        # Initialize dependency injection
        self.container = Container()
        self.logger = self.container.logger()
        self.database = self.container.database()

        self.app = FastAPI(title="Echo Vibe - Artist Query APIs",
                           version="1.0.0",
                           lifespan=lifespan)
        self.logger.info(
            f"\n{banner}\n{APP_NAME} {configuration.get_build_number()}\nPowered by FastAPI\n"
        )

        # # Set routes
        self.app.include_router(apiRouter)
        self.logger.info("App is initialized successfully.")


app_initializer = AppInitializer()
app = app_initializer.app
container = app_initializer.container
