from fastapi import APIRouter
from app.core.container import Container
from dependency_injector.wiring import Provide
from app.core.logger import Logger
from app.service.artist_service import ArtistService
from app.schema.schema import ResponseSchema, ok
from app.schema.artist_schema import ArtistStatsSchema
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse

artist_router = APIRouter(prefix="/v1/artists", tags=["Artist"])

logger: Logger = Provide[Container.logger]
artist_service: ArtistService = Provide[Container.artist_service]


@artist_router.get(path="/{id}/stats",
                   response_model=ResponseSchema[ArtistStatsSchema])
async def get_artist_stats(id: str):
    artist_stats_schema = artist_service.get_artist_stats(id)
    response_scheme = ok(data=artist_stats_schema)
    return JSONResponse(content=jsonable_encoder(response_scheme))
