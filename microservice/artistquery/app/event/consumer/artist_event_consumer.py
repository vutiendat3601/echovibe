from app.constant.constant import ARTIST_CREATED_EVENT, ARTIST_PUBLISHED_EVENT, ARTIST_UPDATED_EVENT, ARTIST_DELETED_EVENT, ARTIST_VISIBILITY_CHANGED_EVENT, APP_NAME
from app.core.configuration import configuration
from app.repository.artist_repository import ArtistRepository
from app.core.container import Container
from app.event.schema.artist_event_schema import ArtistCreatedEvent, ArtistPublishedEvent, ArtistUpdatedEvent, ArtistDeletedEvent, ArtistVisibilityChangedEvent
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

kafka_consumer_properties = {
    "bootstrap_servers": kafka_broker_bootstrap_server_urls,
    "group_id": APP_NAME,
    "key_deserializer": lambda k: json.loads(k.decode()) if k else None,
    "value_deserializer": lambda v: json.loads(v.decode()) if v else None
}


# Consumer Listeners ###########################################################
async def listen_artist_created_event():
    artist_created_event_consumer = AIOKafkaConsumer(
        ARTIST_CREATED_EVENT, **kafka_consumer_properties)
    await artist_created_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_CREATED_EVENT}")
    try:
        async for message in artist_created_event_consumer:
            artist_created_event = ArtistCreatedEvent(**message.value)
            logger.info(
                f"Received ArtistCreatedEvent: id={artist_created_event.id}, version={artist_created_event.version}"
            )
            _consume_artist_created_event(artist_created_event)
    finally:
        await artist_created_event_consumer.stop()


async def listen_artist_published_event():
    artist_published_event_consumer = AIOKafkaConsumer(
        ARTIST_PUBLISHED_EVENT, **kafka_consumer_properties)
    await artist_published_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_PUBLISHED_EVENT}")
    try:
        async for message in artist_published_event_consumer:
            artist_published_event = ArtistPublishedEvent(**message.value)
            logger.info(
                f"Received ArtistPublishedEvent: id={artist_published_event.id}, version={artist_published_event.version}"
            )
            _consume_artist_published_event(artist_published_event)
    finally:
        await artist_published_event_consumer.stop()


async def listen_artist_updated_event():
    artist_updated_event_consumer = AIOKafkaConsumer(
        ARTIST_UPDATED_EVENT, **kafka_consumer_properties)
    await artist_updated_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_UPDATED_EVENT}")
    try:
        async for message in artist_updated_event_consumer:
            artist_updated_event = ArtistUpdatedEvent(**message.value)
            logger.info(
                f"Received ArtsitUpdatedEvent: id={artist_updated_event.id}, version={artist_updated_event.version}"
            )
            _consume_artist_updated_event(artist_updated_event)
    finally:
        await artist_updated_event_consumer.stop()


async def listen_artist_deleted_event():
    artist_deleted_event_consumer = AIOKafkaConsumer(
        ARTIST_DELETED_EVENT, **kafka_consumer_properties)
    await artist_deleted_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_DELETED_EVENT}")
    try:
        async for message in artist_deleted_event_consumer:
            artist_deleted_event = ArtistDeletedEvent(**message.value)
            logger.info(
                f"Received ArtistDeletedEvent: id={artist_deleted_event.id}, version={artist_deleted_event.version}"
            )
            _consume_artist_deleted_event(artist_deleted_event)
    finally:
        await artist_deleted_event_consumer.stop()


# Consumer Functions ###########################################################
def _consume_artist_created_event(artist_created_event: ArtistCreatedEvent):
    created_at = datetime.now(timezone.utc)
    artist_props = {
        **artist_created_event.model_dump(), "id": None,
        "aggregate_id": artist_created_event.id,
        "event_timestamp": artist_created_event.timestamp,
        "created_at": created_at,
        "updated_at": created_at,
        "updated_by": artist_created_event.created_by
    }
    artist = Artist(**artist_props)
    artist_repository.save_artist(artist)


def _consume_artist_published_event(
        artist_published_event: ArtistPublishedEvent):
    artist = artist_repository.find_by_aggregate_id(artist_published_event.id)
    if artist is not None:
        artist.urn = artist_published_event.urn
        artist.name = artist_published_event.name
        artist.biography = artist_published_event.biography
        artist.description = artist_published_event.description
        artist.is_published = artist_published_event.is_published
        artist.is_public = artist_published_event.is_public
        artist.is_active = artist_published_event.is_active
        artist.thumbnail_file_key = artist_published_event.thumbnail_file_key
        artist.thumbnail_url = artist_published_event.thumbnail_url
        artist.background_file_key = artist_published_event.background_file_key
        artist.background_url = artist_published_event.background_url
        artist.tags = artist_published_event.tags
        artist.ref_code = artist_published_event.ref_code
        artist.updated_at = datetime.now(timezone.utc)
        artist_repository.save_artist(artist)


def _consume_artist_updated_event(artist_updated_event: ArtistUpdatedEvent):
    artist = artist_repository.find_by_aggregate_id(artist_updated_event.id)
    if artist is not None:
        artist.name = artist_updated_event.name
        artist.biography = artist_updated_event.biography
        artist.description = artist_updated_event.description
        artist.thumbnail_url = artist_updated_event.thumbnail_url
        artist.background_url = artist_updated_event.background_url
        artist.ref_code = artist_updated_event.ref_code
        artist_repository.save_artist(artist)


def _consume_artist_deleted_event(artist_deleted_event: ArtistDeletedEvent):
    if artist_deleted_event.is_soft_deleted:
        artist = artist_repository.find_by_aggregate_id(artist_deleted_event.id)
        if artist is not None:
            artist.is_active = artist_deleted_event.is_active
            artist_repository.save_artist(artist)
    else:
        artist_repository.delete_artist(artist_deleted_event.id)
