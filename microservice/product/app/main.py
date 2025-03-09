from contextlib import asynccontextmanager
from fastapi import FastAPI
from app.util.dependency_util import singleton
from app.router.router import apiRouter
from app.core.container import Container
import asyncio
from app.event.consumer.artist_event_consumer import listen_artist_published_event


@singleton
class AppInitializer:

    def __init__(self):

        @asynccontextmanager
        async def lifespan(_: FastAPI):
            self.logger.info("Starting Kafka consumer...")
            consume_tasks = []
            consume_task = await asyncio.create_task(
                listen_artist_published_event())
            consume_tasks.append(consume_task)
            try:
                yield
            finally:
                self.logger.info("Shutting down Kafka consumer...")
                for consume_task in consume_tasks:
                    consume_task.cancel()
                    try:
                        await consume_task
                    except asyncio.CancelledError:
                        pass

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
