from app.constant.constant import ARTIST_PUBLISHED_EVENT, APP_NAME
from app.core.configuration import configuration
from app.repository.artist_repository import ArtistRepository
from app.core.container import Container
from app.event.schema.artist_event_schema import ArtistPublishedEvent
from app.model.artist import Artist
from dependency_injector.wiring import Provide
from aiokafka import AIOKafkaConsumer
import json
from app.core.logger import Logger
from datetime import datetime, timezone

kafka_broker_bootstrap_server_urls = configuration.get_kafka_broker_bootstrap_server_urls(
)

artist_repository: ArtistRepository = Provide[Container.artist_repository]

logger: Logger = Provide[Container.logger]


async def listen_artist_published_event():
    artist_published_event_consumer = AIOKafkaConsumer(
        f"{ARTIST_PUBLISHED_EVENT}",
        bootstrap_servers=kafka_broker_bootstrap_server_urls,
        group_id=APP_NAME,
        key_deserializer=lambda k: json.loads(k.decode()) if k else None,
        value_deserializer=lambda v: json.loads(v.decode()) if v else None,
    )
    await artist_published_event_consumer.start()
    try:
        async for message in artist_published_event_consumer:
            artist_published_event = ArtistPublishedEvent(**message.value)
            logger.info(
                f"Received ArtistPublishedEvent: id={artist_published_event.id}, version={artist_published_event.version}"
            )
            _consume_artist_published_event(artist_published_event)
    finally:
        await artist_published_event_consumer.stop()
    pass


def _consume_artist_published_event(
        artist_published_event: ArtistPublishedEvent):
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
