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
    database_configuration: DatabaseConfiguration
    kafka_broker_bootstrap_server_urls = None
    cors_origins: list[str] = []

    def __init__(self) -> None:
        self.build_number = os.getenv("BUILD_NUMBER", "unknown")
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
        self.cors_origins = os.getenv("APP_WEB_CORS_ALLOWEDORIGINPATTERNS",
                                      default="").split(",")

    def get_build_number(self) -> str:
        return self.build_number

    def get_database_uri(self) -> str:
        return f"{self.database_configuration.vendor}://{self.database_configuration.username}:{self.database_configuration.password}@{self.database_configuration.host}:{self.database_configuration.port}/{self.database_configuration.name}"

    def get_kafka_broker_bootstrap_server_urls(self) -> str:
        return self.kafka_broker_bootstrap_server_urls

    def get_cors_origins(self) -> list[str]:
        return self.cors_origins


configuration = Configuration()
