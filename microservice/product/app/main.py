from contextlib import asynccontextmanager
from typing import AsyncGenerator
import asyncio
from fastapi import FastAPI
from app.util.dependency_util import singleton
from app.router.router import apiRouter
from app.core.container import Container
from app.event.consumer.artist_event_consumer import listen_artist_published_event


@singleton
class AppInitializer:

    def __init__(self):

        @asynccontextmanager
        async def lifespan(_: FastAPI) -> AsyncGenerator[None, None]:
            self.logger.info("Starting Kafka consumers...")
            consumer_tasks = []
            consumer_listeners = [listen_artist_published_event]
            for consumer_listener in consumer_listeners:
                consumer_tasks.append(asyncio.create_task(consumer_listener()))
            yield
            self.logger.info("Shutting down Kafka consumers...")
            for consumer_task in consumer_tasks:
                consumer_task.cancel()
            self.logger.info("All Kafka consumers stopped.")

        self.app = FastAPI(title="Echo Vibe - Product APIs",
                           version="1.0.0",
                           lifespan=lifespan)

        # Initialize dependency injection
        self.container = Container()
        self.database = self.container.database()

        # # Set routes
        self.app.include_router(apiRouter)
        self.logger = self.container.logger()
        self.logger.info("App is initialized successfully.")


app_initializer = AppInitializer()
app = app_initializer.app
container = app_initializer.container
