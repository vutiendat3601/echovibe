from fastapi import APIRouter, WebSocket

activity_router = APIRouter(prefix="/v1/activity", tags=["Acitivity"])

# artist_service: ArtistService = Provide[Container.artist_service]


@activity_router.websocket(path="/ws")
async def listen_activity_websocket(websocket: WebSocket):
    await websocket.accept()
    while True:
        data_json = await websocket.receive_text()
        # await websocket.send_text(f"Message text was: {data_json}")
        print(data_json)
