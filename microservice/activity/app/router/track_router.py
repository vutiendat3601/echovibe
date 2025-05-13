from fastapi import APIRouter, Query
from app.core.container import Container
from dependency_injector.wiring import Provide
from app.core.logger import Logger
from app.service.track_service import TrackService
from app.schema.schema import ResponseSchema, ok
from app.schema.track_schema import TrackStatsSchema
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
from app.constant.constant import AGGREGATE_ID_LIST_REGEX

track_router = APIRouter(prefix="/v1/tracks", tags=["Track"])

logger: Logger = Provide[Container.logger]
track_service: TrackService = Provide[Container.track_service]


@track_router.get(path="/{id}/stats",
                  response_model=ResponseSchema[TrackStatsSchema])
async def get_track_stats(id: str):
    track_stats_schema = await track_service.get_track_stats(id)
    response_schema = ok(data=track_stats_schema)
    return JSONResponse(content=jsonable_encoder(response_schema))


@track_router.get(path="/stats",
                  response_model=ResponseSchema[TrackStatsSchema])
async def get_track_stats_by_ids(ids: str = Query(
    ..., regex=AGGREGATE_ID_LIST_REGEX)):
    track_stats_schemas = await track_service.get_track_stats_by_ids(
        ids.split(","))
    response_schema = ok(data=track_stats_schemas)
    return JSONResponse(content=jsonable_encoder(response_schema))
