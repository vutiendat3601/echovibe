from dependency_injector.wiring import Provide
from aiokafka import AIOKafkaConsumer
import json
from app.core.logger import Logger
from app.constant.playlist_constant import (PLAYLIST_CREATED_EVENT,
                                            PLAYLIST_UPDATED_EVENT,
                                            PLAYLIST_DELETED_EVENT)
from app.event.handler.playlist_event_handler import PlaylistEventHandler
from app.constant.constant import APP_NAME
from app.core.configuration import configuration
from app.repository.impl.sqlmodel_playlist_repository import PlaylistRepository
from app.core.container import Container
from app.event.schema.playlist_event_schema import (PlaylistCreatedEvent,
                                                    PlaylistUpdatedEvent,
                                                    PlaylistDeletedEvent)

playlist_event_handler: PlaylistEventHandler = Provide[
    Container.playlist_event_handler]

playlist_repository: PlaylistRepository = Provide[Container.playlist_repository]

logger: Logger = Provide[Container.logger]

environement = configuration.get_environment()

kafka_consumer_properties = {
    "bootstrap_servers":
        configuration.get_kafka_broker_bootstrap_server_urls(),
    "group_id":
        f"{APP_NAME}{('' if environement == 'production' else '-' + environement)}",
    "key_deserializer":
        lambda k: json.loads(k.decode()) if k else None,
    "value_deserializer":
        lambda v: json.loads(v.decode()) if v else None,
    "enable_auto_commit":
        False,
    "request_timeout_ms":
        120_000,
    "max_poll_records":
        1,
    "max_poll_interval_ms":
        120_000
}


async def listen_playlist_created_event():
    playlist_created_event_listener = AIOKafkaConsumer(
        PLAYLIST_CREATED_EVENT, **kafka_consumer_properties)
    await playlist_created_event_listener.start()
    logger.info(f"Listening: topic={PLAYLIST_CREATED_EVENT}")
    try:
        async for message in playlist_created_event_listener:
            playlist_created_event = PlaylistCreatedEvent(**message.value)
            logger.info(
                f"Received {PlaylistCreatedEvent.__name__}: id={playlist_created_event.id}, version={playlist_created_event.version}, timestamp={playlist_created_event.timestamp}"
            )
            playlist_event_handler.handle_playlist_created_event(
                playlist_created_event)
            await playlist_created_event_listener.commit()
    except Exception as e:
        logger.info(f"Error when handling {PlaylistCreatedEvent.__name__}: {e}")
    finally:
        await playlist_created_event_listener.stop()
        logger.info(f"Stopped listening: topic={PLAYLIST_CREATED_EVENT}")


async def listen_playlist_updated_event():
    playlist_updated_event_listener = AIOKafkaConsumer(
        PLAYLIST_UPDATED_EVENT, **kafka_consumer_properties)
    await playlist_updated_event_listener.start()
    logger.info(f"Listening: topic={PLAYLIST_UPDATED_EVENT}")
    try:
        async for message in playlist_updated_event_listener:
            playlist_updated_event = PlaylistUpdatedEvent(**message.value)
            logger.info(
                f"Received {PlaylistUpdatedEvent.__name__}: id={playlist_updated_event.id}, version={playlist_updated_event.version}, timestamp={playlist_updated_event.timestamp}"
            )
            playlist_event_handler.handle_playlist_updated_event(
                playlist_updated_event)
            await playlist_updated_event_listener.commit()
    except Exception as e:
        logger.info(f"Error when handling {PlaylistUpdatedEvent.__name__}: {e}")
    finally:
        await playlist_updated_event_listener.stop()
        logger.info(f"Stopped listening: topic={PLAYLIST_UPDATED_EVENT}")


async def listen_playlist_deleted_event():
    playlist_deleted_event_listener = AIOKafkaConsumer(
        PLAYLIST_DELETED_EVENT, **kafka_consumer_properties)
    await playlist_deleted_event_listener.start()
    logger.info(f"Listening: topic={PLAYLIST_DELETED_EVENT}")
    try:
        async for message in playlist_deleted_event_listener:
            playlist_deleted_event = PlaylistDeletedEvent(**message.value)
            logger.info(
                f"Received {PlaylistDeletedEvent.__name__}: id={playlist_deleted_event.id}, version={playlist_deleted_event.version}, timestamp={playlist_deleted_event.timestamp}"
            )
            playlist_event_handler.handle_playlist_deleted_event(
                playlist_deleted_event)
            await playlist_deleted_event_listener.commit()
    except Exception as e:
        logger.info(f"Error when handling {PlaylistDeletedEvent.__name__}: {e}")
    finally:
        await playlist_deleted_event_listener.stop()
        logger.info(f"Stopped listening: topic={PLAYLIST_DELETED_EVENT}")


def get_playlist_event_listeners() -> list[callable]:
    return [
        listen_playlist_created_event, listen_playlist_updated_event,
        listen_playlist_deleted_event
    ]
