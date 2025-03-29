from contextlib import asynccontextmanager
from typing import AsyncGenerator
from pathlib import Path
import asyncio
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.util.dependency_util import singleton
from app.router.router import apiRouter
from app.core.container import Container
from app.core.configuration import configuration
from app.constant.constant import APP_NAME
from app.event.listener.artist_event_listener import get_artist_event_listeners

banner = Path("banner.txt").read_text()


@singleton
class AppInitializer:

    def __init__(self):

        @asynccontextmanager
        async def lifespan(_: FastAPI) -> AsyncGenerator[None, None]:
            self.logger.info("Starting Kafka consumers...")
            consumer_tasks = []
            consumer_listeners: list[callable] = get_artist_event_listeners()
            for consumer_listener in consumer_listeners:
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
                           lifespan=lifespan,
                           openapi_url="/v1/artists/openapi")
        allow_origins: list[
            str] = configuration.get_web_cors_alllowed_origin_patterns(),
        allow_methods: list[str] = configuration.get_web_cors_allowed_methods(),
        allow_headers = configuration.get_web_cors_allow_headers(),
        allow_credentials = configuration.get_web_cors_allow_credentials(),
        max_age = configuration.get_web_cors_maxage()
        self.app.add_middleware(CORSMiddleware,
                                allow_origins=allow_origins[0],
                                allow_methods=allow_methods[0],
                                allow_headers=allow_headers[0],
                                allow_credentials=allow_credentials[0],
                                max_age=max_age)
        self.logger.info(f"""
{banner}
{APP_NAME} {configuration.get_build_number()}
Powered by FastAPI
""")
        print(allow_credentials)
        self.logger.info(allow_credentials)
        self.logger.info(
            f"Cross-origin resource sharing (CORS) configuration: allowedOriginPatterns={allow_origins[0]}, allowedMethods={allow_methods[0]}, allowedHeaders={allow_headers[0]}, allowCredentials={allow_credentials[0]}, maxAge={max_age}"
        )

        # # Set routes
        self.app.include_router(apiRouter)
        self.logger.info("App is initialized successfully.")


app_initializer = AppInitializer()
app = app_initializer.app
container = app_initializer.container
