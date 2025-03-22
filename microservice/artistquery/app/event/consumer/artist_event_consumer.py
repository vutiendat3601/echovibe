from dependency_injector.wiring import Provide
from aiokafka import AIOKafkaConsumer
import json
from app.core.logger import Logger
from datetime import datetime, timezone
from app.constant.artist_constant import ARTIST_CREATED_EVENT, ARTIST_RELEASED_EVENT, ARTIST_UPDATED_EVENT, ARTIST_DELETED_EVENT, ARTIST_VISIBILITY_SET_EVENT
from app.constant.constant import APP_NAME
from app.core.configuration import configuration
from app.repository.artist_repository import ArtistRepository
from app.core.container import Container
from app.event.schema.artist_event_schema import ArtistCreatedEvent, ArtistReleasedEvent, ArtistProfileUpdatedEvent, ArtistDeletedEvent, ArtistVisibilitySetEvent
from app.model.artist import Artist, ArtistProfile, ArtistImage
from app.constant.artist_image_type import ArtistImageType

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


async def listen_artist_released_event():
    artist_published_event_consumer = AIOKafkaConsumer(
        ARTIST_RELEASED_EVENT, **kafka_consumer_properties)
    await artist_published_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_RELEASED_EVENT}")
    try:
        async for message in artist_published_event_consumer:
            artist_published_event = ArtistReleasedEvent(**message.value)
            logger.info(
                f"Received ArtistReleasedEvent: id={artist_published_event.id}, version={artist_published_event.version}"
            )
            _consume_artist_released_event(artist_published_event)
    finally:
        await artist_published_event_consumer.stop()


async def listen_artist_profile_updated_event():
    artist_updated_event_consumer = AIOKafkaConsumer(
        ARTIST_UPDATED_EVENT, **kafka_consumer_properties)
    await artist_updated_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_UPDATED_EVENT}")
    try:
        async for message in artist_updated_event_consumer:
            artist_updated_event = ArtistProfileUpdatedEvent(**message.value)
            logger.info(
                f"Received ArtistProfileUpdatedEvent: id={artist_updated_event.id}, version={artist_updated_event.version}"
            )
            _consume_artist_profile_updated_event(artist_updated_event)
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


async def listen_artist_visibility_set_event():
    artist_visibility_changed_event_consumer = AIOKafkaConsumer(
        ARTIST_VISIBILITY_SET_EVENT, **kafka_consumer_properties)
    await artist_visibility_changed_event_consumer.start()
    logger.info(f"Listening: topic={ARTIST_VISIBILITY_SET_EVENT}")
    try:
        async for message in artist_visibility_changed_event_consumer:
            artist_visibility_set_event = ArtistVisibilitySetEvent(
                **message.value)
            logger.info(
                f"Received ArtistVisibilitySetEvent: id={artist_visibility_set_event.id}, version={artist_visibility_set_event.version}"
            )
            _consume_artist_visibility_changed_event(
                artist_visibility_set_event)
    finally:
        await artist_visibility_changed_event_consumer.stop()


def get_artist_event_listeners() -> list[callable]:
    return [
        listen_artist_created_event, listen_artist_released_event,
        listen_artist_profile_updated_event, listen_artist_deleted_event,
        listen_artist_visibility_set_event
    ]


# Consumer Functions ###########################################################


def _consume_artist_created_event(artist_created_event: ArtistCreatedEvent):
    created_at = datetime.now(timezone.utc)
    artist_profile_attributes = {
        **artist_created_event.profile.model_dump(), "id": None,
        "aggregate_id": artist_created_event.id,
        "artist_ref_code": artist_created_event.ref_code,
        "event_type": artist_created_event.type,
        "event_version": artist_created_event.version,
        "event_timestamp": artist_created_event.timestamp,
        "created_at": created_at,
        "updated_at": created_at,
        "created_by": artist_created_event.created_by,
        "updated_by": artist_created_event.created_by
    }
    artist_profile = ArtistProfile(**artist_profile_attributes)

    artist_props = {
        **artist_created_event.model_dump(), "id": None,
        "images": [],
        "profile": artist_profile,
        "aggregate_id": artist_created_event.id,
        "event_type": artist_created_event.type,
        "event_version": artist_created_event.version,
        "event_timestamp": artist_created_event.timestamp,
        "created_at": created_at,
        "updated_at": created_at,
        "created_by": artist_created_event.created_by,
        "updated_by": artist_created_event.created_by
    }
    artist = Artist(**artist_props)
    if artist_created_event.profile.thumbnail_url is not None:
        artist.images.append(
            ArtistImage(file_url=artist_created_event.profile.thumbnail_url,
                        artist_ref_code=artist_created_event.ref_code,
                        type=ArtistImageType.THUMBNAIL,
                        aggregate_id=artist_created_event.id,
                        event_type=artist_created_event.type,
                        event_version=artist_created_event.version,
                        event_timestamp=artist_created_event.timestamp,
                        created_at=created_at,
                        updated_at=created_at,
                        created_by=artist_created_event.created_by,
                        updated_by=artist_created_event.created_by))
    if artist_created_event.profile.background_url is not None:
        artist.images.append(
            ArtistImage(file_url=artist_created_event.profile.background_url,
                        artist_ref_code=artist_created_event.ref_code,
                        type=ArtistImageType.BACKGROUND,
                        aggregate_id=artist_created_event.id,
                        event_type=artist_created_event.type,
                        event_version=artist_created_event.version,
                        event_timestamp=artist_created_event.timestamp,
                        created_at=created_at,
                        updated_at=created_at,
                        created_by=artist_created_event.created_by,
                        updated_by=artist_created_event.created_by))
    artist_repository.save_artist(artist)
    logger.info(
        f"Processed ArtistCreatedEvent: id={artist_created_event.id}, version={artist_created_event.version}"
    )


def _consume_artist_released_event(artist_released_event: ArtistReleasedEvent):
    updated_at = datetime.now(timezone.utc)
    artist = artist_repository.find_by_aggregate_id(artist_released_event.id)
    if artist is not None:
        if artist.profile is None:
            artist.profile = ArtistProfile()
        artist.urn = artist_released_event.urn
        artist.profile.name = artist_released_event.profile.name
        artist.profile.biography = artist_released_event.profile.biography
        artist.profile.description = artist_released_event.profile.description
        artist.is_released = artist_released_event.is_released
        artist.is_public = artist_released_event.is_public
        artist.is_active = artist_released_event.is_active
        artist.profile.thumbnail_file_key = artist_released_event.profile.thumbnail_file_key
        artist.profile.thumbnail_url = artist_released_event.profile.thumbnail_url
        artist.profile.background_file_key = artist_released_event.profile.background_file_key
        artist.profile.background_url = artist_released_event.profile.background_url
        artist.tags = artist_released_event.tags
        artist.event_type = artist_released_event.type
        artist.event_version = artist_released_event.version
        artist.event_timestamp = artist_released_event.timestamp
        artist.updated_at = updated_at
        artist_repository.save_artist(artist)
    logger.info(
        f"Processed ArtistReleasedEvent: id={artist_released_event.id}, version={artist_released_event.version}"
    )


def _consume_artist_profile_updated_event(
        artist_profile_updated_event: ArtistProfileUpdatedEvent):
    updated_at = datetime.now(timezone.utc)
    artist = artist_repository.find_by_aggregate_id(
        artist_profile_updated_event.id)
    if artist is not None:
        if artist.profile is None:
            artist.profile = ArtistProfile()
        artist.profile.name = artist_profile_updated_event.profile.name
        artist.profile.biography = artist_profile_updated_event.profile.biography
        artist.profile.description = artist_profile_updated_event.profile.description
        artist.profile.thumbnail_url = artist_profile_updated_event.profile.thumbnail_url
        artist.profile.background_url = artist_profile_updated_event.profile.background_url
        artist.event_type = artist_profile_updated_event.type
        artist.event_timestamp = artist_profile_updated_event.timestamp
        artist.event_version = artist_profile_updated_event.version
        artist.updated_at = updated_at
        artist_repository.save_artist(artist)
    logger.info(
        f"Processed ArtistProfileUpdatedEvent: id={artist_profile_updated_event.id}, version={artist_profile_updated_event.version}"
    )


def _consume_artist_deleted_event(artist_deleted_event: ArtistDeletedEvent):
    updated_at = datetime.now(timezone.utc)
    if artist_deleted_event.is_soft_deleted:
        artist = artist_repository.find_by_aggregate_id(artist_deleted_event.id)
        if artist is not None:
            artist.is_active = artist_deleted_event.is_active
            artist.event_type = artist_deleted_event.type
            artist.event_version = artist_deleted_event.version
            artist.event_timestamp = artist_deleted_event.timestamp
            artist.updated_at = updated_at
            artist_repository.save_artist(artist)
    else:
        artist_repository.delete_artist(artist_deleted_event.id)
    logger.info(
        f"Processed ArtistDeletedEvent: id={artist_deleted_event.id}, version={artist_deleted_event.version}"
    )


def _consume_artist_visibility_changed_event(
        artist_visibility_set_event: ArtistVisibilitySetEvent):
    updated_at = datetime.now(timezone.utc)
    artist = artist_repository.find_by_aggregate_id(
        artist_visibility_set_event.id)
    if artist is not None:
        artist.is_public = artist_visibility_set_event.is_public
        artist.event_timestamp = artist_visibility_set_event.timestamp
        artist.event_type = artist_visibility_set_event.type
        artist.event_version = artist_visibility_set_event.version
        artist.updated_at = updated_at
        artist_repository.save_artist(artist)
    logger.info(
        f"Processed ArtistVisibilitySetEvent: id={artist_visibility_set_event.id}, version={artist_visibility_set_event.version}"
    )
