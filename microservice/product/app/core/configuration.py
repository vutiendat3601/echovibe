import os
from dotenv import load_dotenv

load_dotenv()


class DatabaseConfiguration:
    vendor: str
    username: str
    password: str
    host: str
    port: int
    name: str


class Configuration:
    build_number = None
    web_cors_alllowed_origin_patterns: list[str] = None
    web_cors_allowed_methods: list[str] = []
    web_cors_allow_headers: list[str] = []
    web_cors_allow_credentials: bool = True
    web_cors_cors_maxage: int
    database_configuration: DatabaseConfiguration
    kafka_broker_bootstrap_server_urls = None

    def __init__(self) -> None:
        self.build_number = os.getenv("BUILD_NUMBER", "unknown")
        self.web_cors_alllowed_origin_patterns = os.getenv(
            "APP_WEB_CORS_ALLOWEDORIGINPATTERNS", default="*")[0].split(",")
        self.web_cors_allowed_methods = os.getenv("APP_WEB_CORS_ALLOWEDMETHODS",
                                                  default="*")[0].split(",")
        self.web_cors_allow_headers = os.getenv("APP_WEB_CORS_ALLOWEDHEADERS",
                                                default="*")[0].split(",")
        self.web_cors_allow_credentials = eval(
            os.getenv("APP_WEB_CORS_ALLOWCREDENTIALS", default="True"))
        self.web_cors_cors_maxage = int(
            os.getenv("APP_WEB_CORS_MAXAGE", default="0"))
        self.database_configuration = DatabaseConfiguration()
        self.database_configuration.vendor = os.getenv("DATABASE_VENDOR",
                                                       "postgresql+psycopg")
        self.database_configuration.host = os.getenv("DATABASE_HOST")
        self.database_configuration.port = int(
            os.getenv("DATABASE_PORT", "5432"))
        self.database_configuration.username = os.getenv("DATABASE_USERNAME")
        self.database_configuration.password = os.getenv("DATABASE_PASSWORD")
        self.database_configuration.name = os.getenv("DATABASE_NAME")
        self.kafka_broker_bootstrap_server_urls = os.getenv(
            "KAFKA_BROKER_BOOTSTRAP_SERVER_URLS")

    def get_build_number(self) -> str:
        return self.build_number

    def get_web_cors_alllowed_origin_patterns(self) -> list[str]:
        return self.web_cors_alllowed_origin_patterns

    def get_web_cors_allowed_methods(self) -> list[str]:
        return self.web_cors_allowed_methods

    def get_web_cors_allow_headers(self) -> list[str]:
        return self.web_cors_allow_headers

    def get_web_cors_allow_credentials(self) -> bool:
        return self.web_cors_allow_credentials

    def get_web_cors_maxage(self) -> int:
        return self.web_cors_cors_maxage

    def get_database_uri(self) -> str:
        return f"{self.database_configuration.vendor}://{self.database_configuration.username}:{self.database_configuration.password}@{self.database_configuration.host}:{self.database_configuration.port}/{self.database_configuration.name}"

    def get_kafka_broker_bootstrap_server_urls(self) -> str:
        return self.kafka_broker_bootstrap_server_urls


configuration = Configuration()
