from dependency_injector.wiring import Provide
from aiokafka import AIOKafkaConsumer
import json
from app.core.logger import Logger
from datetime import datetime, timezone
from app.constant.constant import ARTIST_PUBLISHED_EVENT, APP_NAME
from app.core.configuration import configuration
from app.repository.artist_repository import ArtistRepository
from app.core.container import Container
from app.event.schema.artist_event_schema import ArtistReleasedEvent
from app.model.artist import Artist

kafka_broker_bootstrap_server_urls = configuration.get_kafka_broker_bootstrap_server_urls(
)

artist_repository: ArtistRepository = Provide[Container.artist_repository]

logger: Logger = Provide[Container.logger]

kafka_consumer_properties = {
    "bootstrap_servers": kafka_broker_bootstrap_server_urls,
    "group_id": APP_NAME,
    "key_deserializer": lambda k: json.loads(k.decode()) if k else None,
    "value_deserializer": lambda v: json.loads(v.decode()) if v else None
}


# Consumer Listeners ###########################################################
async def listen_artist_published_event():
    artist_published_event_consumer = AIOKafkaConsumer(
        ARTIST_PUBLISHED_EVENT, **kafka_consumer_properties)
    await artist_published_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_PUBLISHED_EVENT}")
    try:
        async for message in artist_published_event_consumer:
            artist_published_event = ArtistReleasedEvent(**message.value)
            logger.info(
                f"Received ArtistPublishedEvent: id={artist_published_event.id}, version={artist_published_event.version}"
            )
            _consume_artist_published_event(artist_published_event)
    finally:
        await artist_published_event_consumer.stop()


def get_artist_event_listeners() -> list[callable]:
    return [listen_artist_published_event]


# Consumer Functions ###########################################################


def _consume_artist_published_event(
        artist_published_event: ArtistReleasedEvent):
    created_at = datetime.now(timezone.utc)
    artist_props = {
        **artist_published_event.model_dump(), "id": None,
        "aggregate_id": artist_published_event.id,
        "event_timestamp": artist_published_event.timestamp,
        "created_at": created_at,
        "updated_at": created_at,
        "updated_by": artist_published_event.created_by
    }
    artist = Artist(**artist_props)
    artist_repository.save_artist(artist)
