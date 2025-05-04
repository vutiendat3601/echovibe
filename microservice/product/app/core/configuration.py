import os
from dotenv import load_dotenv
from app.constant.constant import APP_NAME
import json

load_dotenv()


class DatabaseConfiguration:
    vendor: str
    username: str
    password: str
    host: str
    port: int
    name: str


class Configuration:
    _build_number = None
    _environment: str
    _web_cors_alllowed_origin_patterns: list[str] = None
    _web_cors_allowed_methods: list[str] = []
    _web_cors_allow_headers: list[str] = []
    _web_cors_allow_credentials: bool = True
    _web_cors_cors_maxage: int
    _database_configuration: DatabaseConfiguration
    _kafka_broker_bootstrap_server_urls = None
    _open_id_connect_certs_url: str | None = None
    _redis_url: str | None = None

    def __init__(self) -> None:
        self._build_number = os.getenv("BUILD_NUMBER", "unknown")
        self._environment = os.getenv("ENVIRONMENT", "development")
        self._web_cors_alllowed_origin_patterns = os.getenv(
            "APP_WEB_CORS_ALLOWEDORIGINPATTERNS", default="*")[0].split(",")
        self._web_cors_allowed_methods = os.getenv(
            "APP_WEB_CORS_ALLOWEDMETHODS", default="*")[0].split(",")
        self._web_cors_allow_headers = os.getenv("APP_WEB_CORS_ALLOWEDHEADERS",
                                                 default="*")[0].split(",")
        self._web_cors_allow_credentials = eval(
            os.getenv("APP_WEB_CORS_ALLOWCREDENTIALS", default="True"))
        self._web_cors_cors_maxage = int(
            os.getenv("APP_WEB_CORS_MAXAGE", default="0"))
        self._database_configuration = DatabaseConfiguration()
        self._database_configuration.vendor = os.getenv("DATABASE_VENDOR",
                                                        "postgresql+psycopg")
        self._database_configuration.host = os.getenv("DATABASE_HOST")
        self._database_configuration.port = int(
            os.getenv("DATABASE_PORT", "5432"))
        self._database_configuration.username = os.getenv("DATABASE_USERNAME")
        self._database_configuration.password = os.getenv("DATABASE_PASSWORD")
        self._database_configuration.name = os.getenv("DATABASE_NAME")
        self._kafka_broker_bootstrap_server_urls = os.getenv(
            "KAFKA_BROKER_BOOTSTRAP_SERVER_URLS")
        self._open_id_connect_certs_url = os.getenv(
            "APP_WEB_AUTH_OPENIDCONNECTCERTSURL")
        self._redis_url = os.getenv("REDIS_URL")

    def get_build_number(self) -> str:
        return self._build_number

    def get_web_cors_alllowed_origin_patterns(self) -> list[str]:
        return self._web_cors_alllowed_origin_patterns

    def get_web_cors_allowed_methods(self) -> list[str]:
        return self._web_cors_allowed_methods

    def get_web_cors_allow_headers(self) -> list[str]:
        return self._web_cors_allow_headers

    def get_web_cors_allow_credentials(self) -> bool:
        return self._web_cors_allow_credentials

    def get_web_cors_maxage(self) -> int:
        return self._web_cors_cors_maxage

    def get_database_uri(self) -> str:
        return f"{self._database_configuration.vendor}://{self._database_configuration.username}:{self._database_configuration.password}@{self._database_configuration.host}:{self._database_configuration.port}/{self._database_configuration.name}"

    def get_kafka_broker_bootstrap_server_urls(self) -> str:
        return self._kafka_broker_bootstrap_server_urls

    def get_environment(self) -> str:
        return self._environment

    def get_kafka_consumer_properties(self) -> dict[str, any]:
        return {
            "bootstrap_servers":
                self._kafka_broker_bootstrap_server_urls,
            "group_id":
                f"{APP_NAME}{('' if self._environment == 'production' else '-' + self._environment)}",
            "key_deserializer":
                lambda k: json.loads(k.decode()) if k else None,
            "value_deserializer":
                lambda v: json.loads(v.decode()) if v else None,
            "enable_auto_commit":
                False,
            "request_timeout_ms":
                60_000,
            "max_poll_records":
                1,
            "max_poll_interval_ms":
                270_000,
            "session_timeout_ms":
                90_000,
            "heartbeat_interval_ms":
                30_000
        }

    def get_open_id_connect_certs_url(self) -> str:
        return self._open_id_connect_certs_url

    def get_redis_url(self) -> str:
        return self._redis_url


configuration = Configuration()
