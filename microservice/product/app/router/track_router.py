from fastapi import APIRouter, Query
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.track_schema import (TrackDetailSchema)
from app.service.track_service import TrackService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.constant.constant import AGGREGATE_ID_LIST_REGEX

track_router = APIRouter(prefix="/v1/tracks", tags=["Track"])

track_service: TrackService = Provide[Container.track_service]


@track_router.get("/{id}", response_model=ResponseSchema[TrackDetailSchema])
def get_track_by_id(id: str):
    track_detail_schema = track_service.get_track_by_aggregate_id(
        aggregate_id=id)
    response_scheme = ok(data=track_detail_schema)
    return JSONResponse(content=jsonable_encoder(response_scheme))


@track_router.get(path="",
                  response_model=ResponseSchema[list[TrackDetailSchema]])
def get_track_by_ids(ids: str = Query(..., regex=AGGREGATE_ID_LIST_REGEX)):
    track_detail_schemas = track_service.get_track_by_aggregate_ids(
        ids.split(","))
    response = ok(data=track_detail_schemas)
    return JSONResponse(content=jsonable_encoder(response))
