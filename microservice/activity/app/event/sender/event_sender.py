import json
from app.core.logger import Logger
from app.core.configuration import configuration
from aiokafka import AIOKafkaProducer
from app.event.schema.event_schema import EventSchema

kafka_producer_properties = {
    "bootstrap_servers": configuration.get_kafka_broker_bootstrap_server_urls()
}


async def send_event(topic: str, event: EventSchema, logger: Logger):
    producer = AIOKafkaProducer(**kafka_producer_properties)
    await producer.start()
    try:
        event_json = event.model_dump_json(by_alias=True)
        await producer.send_and_wait(topic, event_json.encode("utf-8"))
        logger.info(
            f"Sent {event.type}: id={event.id}, version={event.version}, timestamp={event.timestamp}"
        )
    except Exception as e:
        logger.error(f"Send {event.type} error: {e}")
    finally:
        await producer.stop()
