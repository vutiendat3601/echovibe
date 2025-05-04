from pathlib import Path
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI
from app.util.dependency_util import singleton
from app.router.router import api_router
from app.core.container import Container
from app.core.configuration import configuration
from app.constant.constant import APP_NAME

banner = Path("banner.txt").read_text()


@singleton
class AppInitializer:

    def __init__(self):

        # Initialize dependency injection
        self.container = Container()
        self.logger = self.container.logger()
        self.database = self.container.database()

        self.app = FastAPI(title="Echo Vibe - Activity APIs",
                           version="1.0.0",
                           openapi_url="/v1/openapi")
        allow_origins: list[
            str] = configuration.get_web_cors_alllowed_origin_patterns()
        allow_methods: list[str] = configuration.get_web_cors_allowed_methods()
        allow_headers = configuration.get_web_cors_allow_headers()
        allow_credentials = configuration.get_web_cors_allow_credentials()
        max_age = configuration.get_web_cors_maxage()
        self.app.add_middleware(CORSMiddleware,
                                allow_origins=allow_origins,
                                allow_methods=allow_methods,
                                allow_headers=allow_headers,
                                allow_credentials=allow_credentials,
                                max_age=max_age)
        self.logger.info(f"""
{banner}
{APP_NAME} {configuration.get_build_number()}
Powered by FastAPI
""")
        self.logger.info(allow_credentials)
        self.logger.info(
            f"Cross-origin resource sharing (CORS) configuration: allowedOriginPatterns={allow_origins}, allowedMethods={allow_methods}, allowedHeaders={allow_headers}, allowCredentials={allow_credentials}, maxAge={max_age}"
        )

        # Set routes
        self.app.include_router(api_router)
        self.logger.info("App is initialized successfully.")


app_initializer = AppInitializer()
app = app_initializer.app
container = app_initializer.container
