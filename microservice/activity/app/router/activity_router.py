from fastapi import APIRouter, WebSocket
from app.core.container import Container
from dependency_injector.wiring import Provide
from app.core.logger import Logger
from app.util.jwt_extractor import verify_jwt_token
from app.service.activity_service import ActivityService
from app.schema.activity_schema import ActivitySchema
import json

activity_router = APIRouter(prefix="/v1", tags=["Acitivity"])

logger: Logger = Provide[Container.logger]
activity_service: ActivityService = Provide[Container.activity_service]


@activity_router.websocket(path="/ws")
async def listen_activity_websocket(websocket: WebSocket):
    authorization = websocket.headers.get("Authorization")
    jwt_claims = {}
    if (authorization):
        authorization = authorization.removeprefix("Bearer ")
        jwt_claims = verify_jwt_token(authorization)
    try:
        await websocket.accept()
        while True:
            message = await websocket.receive_text()
            message_json = json.loads(message)
            create_activity_schema: ActivitySchema = ActivitySchema(
                **message_json)
            aggregate_id = activity_service.handle_activity(
                create_activity_schema, jwt_claims)
            if aggregate_id:
                await websocket.send_text(
                    json.dumps({"id": aggregate_id}))

    except Exception as e:
        logger.error(f"Error processing message: {e}")
        await websocket.send_text(
            json.dumps({"error": "Failed to process message"}))
    finally:
        await websocket.close()
        logger.info("WebSocket connection closed")
