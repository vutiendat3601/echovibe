from fastapi import APIRouter, WebSocket
from app.core.container import Container
from dependency_injector.wiring import Provide
from app.core.logger import Logger
from app.util.jwt_extractor import verify_jwt_token
from app.service.activity_service import ActivityService
from app.schema.activity_schema import ActivitySchema
from fastapi.encoders import jsonable_encoder
import json
from app.schema.activity_schema import MessageResponseSchema

activity_router = APIRouter(prefix="/v1", tags=["Acitivity"])

logger: Logger = Provide[Container.logger]
activity_service: ActivityService = Provide[Container.activity_service]


@activity_router.websocket(path="/ws")
async def listen_activity_websocket(websocket: WebSocket):
    jwt = websocket.query_params.get("jwt")
    jwt_claims = {}
    if (jwt):
        jwt_claims = verify_jwt_token(jwt)
    try:
        await websocket.accept()
        while True:
            message = await websocket.receive_text()
            message_json = json.loads(message)
            create_activity_schema: ActivitySchema = ActivitySchema(
                **message_json)
            processed_data: MessageResponseSchema | None = activity_service.handle_activity(
                create_activity_schema, jwt_claims)
            if processed_data:
                await websocket.send_text(processed_data.model_dump_json())

    except Exception as e:
        logger.error(f"Error processing message: {e}")
        await websocket.send_text(
            json.dumps({"error": "Failed to process message"}))
    finally:
        await websocket.close()
        logger.info("WebSocket connection closed")
