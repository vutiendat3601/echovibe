from dependency_injector.wiring import Provide
from aiokafka import AIOKafkaConsumer
import json
from app.core.logger import Logger
from app.constant.track_constant import (TRACK_RELEASED_EVENT,
                                         TRACK_DELETED_EVENT)
from app.event.handler.track_event_handler import TrackEventHandler
from app.constant.constant import APP_NAME
from app.core.configuration import configuration
from app.repository.impl.sqlmodel_track_repository import TrackRepository
from app.core.container import Container
from app.event.schema.track_event_schema import (TrackReleasedEvent,
                                                 TrackDeletedEvent)

kafka_broker_bootstrap_server_urls = configuration.get_kafka_broker_bootstrap_server_urls(
)
track_event_handler: TrackEventHandler = Provide[Container.track_event_handler]

track_repository: TrackRepository = Provide[Container.track_repository]

logger: Logger = Provide[Container.logger]

environement = configuration.get_environment()

kafka_consumer_properties = {
    "bootstrap_servers":
        kafka_broker_bootstrap_server_urls,
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


async def listen_track_released_event():
    track_released_event_listener = AIOKafkaConsumer(
        TRACK_RELEASED_EVENT, **kafka_consumer_properties)
    await track_released_event_listener.start()
    logger.info(f"Listening: topic={TRACK_RELEASED_EVENT}")
    try:
        async for message in track_released_event_listener:
            track_released_event = TrackReleasedEvent(**message.value)
            logger.info(
                f"Received {TrackReleasedEvent.__name__}: id={track_released_event.id}, version={track_released_event.version}, timestamp={track_released_event.timestamp}"
            )
            track_event_handler.handle_track_released_event(
                track_released_event)
            await track_released_event_listener.commit()
    except Exception as e:
        logger.info(f"Error when handling {TrackReleasedEvent.__name__}: {e}")
    finally:
        await track_released_event_listener.stop()
        logger.info(f"Stopped listening: topic={TRACK_RELEASED_EVENT}")


async def listen_track_deleted_event():
    track_deleted_event_consumer = AIOKafkaConsumer(TRACK_DELETED_EVENT,
                                                    **kafka_consumer_properties)
    await track_deleted_event_consumer.start()
    logger.info(f"Listening: topic={TRACK_DELETED_EVENT}")
    try:
        async for message in track_deleted_event_consumer:
            track_deleted_event = TrackDeletedEvent(**message.value)
            logger.info(
                f"Received {TrackDeletedEvent.__name__}: id={track_deleted_event.id}, version={track_deleted_event.version}, timestamp={track_deleted_event.timestamp}"
            )
            track_event_handler.handle_track_deleted_event(track_deleted_event)
            await track_deleted_event_consumer.commit()
    except Exception as e:
        logger.info(f"Error when handling {TrackDeletedEvent.__name__}: {e}")
    finally:
        await track_deleted_event_consumer.stop()
        logger.info(f"Stopped listening: topic={TRACK_DELETED_EVENT}")


def get_track_event_listeners() -> list[callable]:
    return [listen_track_released_event, listen_track_deleted_event]
