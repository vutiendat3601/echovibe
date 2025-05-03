from fastapi import APIRouter, WebSocket
from app.core.container import Container
from dependency_injector.wiring import Provide
from app.core.logger import Logger

activity_router = APIRouter(prefix="/v1", tags=["Acitivity"])

# artist_service: ArtistService = Provide[Container.artist_service]

logger: Logger = Provide[Container.logger]


@activity_router.websocket(path="/ws")
async def listen_activity_websocket(websocket: WebSocket):
    await websocket.accept()
    while True:
        data_json = await websocket.receive_text()
        # await websocket.send_text(f"Message text was: {data_json}")
        logger.info(f"Message text was: {data_json}")
