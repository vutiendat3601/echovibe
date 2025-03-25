from dependency_injector.wiring import Provide
from aiokafka import AIOKafkaConsumer
import json
from app.core.logger import Logger
from app.constant.artist_constant import (ARTIST_CREATED_EVENT,
                                          ARTIST_RELEASED_EVENT,
                                          ARTIST_UPDATED_EVENT,
                                          ARTIST_DELETED_EVENT,
                                          ARTIST_VERIFICATION_SET_EVENT)
from app.event.handler.artist_event_handler import (
    handle_artist_created_event, handle_artist_deleted_event,
    handle_artist_released_event, handle_artist_updated_event,
    handle_artist_verification_set_event)
from app.constant.constant import APP_NAME
from app.core.configuration import configuration
from app.repository.artist_repository import ArtistRepository
from app.core.container import Container
from app.event.schema.artist_event_schema import (ArtistCreatedEvent,
                                                  ArtistReleasedEvent,
                                                  ArtistUpdatedEvent,
                                                  ArtistDeletedEvent,
                                                  ArtistVerificationSetEvent)

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


async def listen_artist_created_event():
    artist_created_event_listener = AIOKafkaConsumer(
        ARTIST_CREATED_EVENT, **kafka_consumer_properties)
    await artist_created_event_listener.start()
    logger.info(f"Listening: topic={ARTIST_CREATED_EVENT}")
    try:
        async for message in artist_created_event_listener:
            artist_created_event = ArtistCreatedEvent(**message.value)
            logger.info(
                f"Received {ArtistCreatedEvent.__name__}: id={artist_created_event.id}, version={artist_created_event.version}"
            )
            handle_artist_created_event(artist_created_event)
    finally:
        await artist_created_event_listener.stop()


async def listen_artist_released_event():
    artist_released_event_listener = AIOKafkaConsumer(
        ARTIST_RELEASED_EVENT, **kafka_consumer_properties)
    await artist_released_event_listener.start()
    logger.info(f"Listening: topic={ARTIST_RELEASED_EVENT}")
    try:
        async for message in artist_released_event_listener:
            artist_released_event = ArtistReleasedEvent(**message.value)
            logger.info(
                f"Received {ArtistReleasedEvent.__name__}: id={artist_released_event.id}, version={artist_released_event.version}, timestamp={artist_released_event.timestamp}"
            )
            handle_artist_released_event(artist_released_event)
    finally:
        await artist_released_event_listener.stop()


async def listen_artist_profile_updated_event():
    artist_updated_event_listener = AIOKafkaConsumer(
        ARTIST_UPDATED_EVENT, **kafka_consumer_properties)
    await artist_updated_event_listener.start()
    logger.info(f"Listening: topic={ARTIST_UPDATED_EVENT}")
    try:
        async for message in artist_updated_event_listener:
            artist_updated_event = ArtistUpdatedEvent(**message.value)
            logger.info(
                f"Received {ArtistUpdatedEvent.__name__}: id={artist_updated_event.id}, version={artist_updated_event.version}, timestamp={artist_updated_event.timestamp}"
            )
            handle_artist_updated_event(artist_updated_event)
    finally:
        await artist_updated_event_listener.stop()


async def listen_artist_deleted_event():
    artist_deleted_event_consumer = AIOKafkaConsumer(
        ARTIST_DELETED_EVENT, **kafka_consumer_properties)
    await artist_deleted_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_DELETED_EVENT}")
    try:
        async for message in artist_deleted_event_consumer:
            artist_deleted_event = ArtistDeletedEvent(**message.value)
            logger.info(
                f"Received {ArtistDeletedEvent.__name__}: id={artist_deleted_event.id}, version={artist_deleted_event.version}, timestamp={artist_deleted_event.timestamp}"
            )
            handle_artist_deleted_event(artist_deleted_event)
    finally:
        await artist_deleted_event_consumer.stop()


async def listen_artist_visibility_set_event():
    artist_visibility_changed_event_consumer = AIOKafkaConsumer(
        ARTIST_VERIFICATION_SET_EVENT, **kafka_consumer_properties)
    await artist_visibility_changed_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_VERIFICATION_SET_EVENT}")
    try:
        async for message in artist_visibility_changed_event_consumer:
            artist_verification_set_event = ArtistVerificationSetEvent(
                **message.value)
            logger.info(
                f"Received {ArtistVerificationSetEvent.__name__}: id={artist_verification_set_event.id}, version={artist_verification_set_event.version}, timestamp={artist_verification_set_event.timestamp}"
            )
            handle_artist_verification_set_event(artist_verification_set_event)
    finally:
        await artist_visibility_changed_event_consumer.stop()


def get_artist_event_listeners() -> list[callable]:
    return [
        listen_artist_created_event, listen_artist_released_event,
        listen_artist_profile_updated_event, listen_artist_deleted_event,
        listen_artist_visibility_set_event
    ]
