from fastapi import APIRouter, Query
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.playlist_schema import (PlaylistDetailSchema)
from app.service.playlist_service import PlaylistService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.constant.constant import AGGREGATE_ID_LIST_REGEX

playlist_router = APIRouter(prefix="/v1/playlists", tags=["Track"])

playlist_service: PlaylistService = Provide[Container.playlist_service]


@playlist_router.get("/{id}",
                     response_model=ResponseSchema[PlaylistDetailSchema])
def get_playlist_by_id(id: str):
    playlist_detail_schema = playlist_service.get_playlist_by_aggregate_id(
        aggregate_id=id)
    response_scheme = ok(data=playlist_detail_schema)
    return JSONResponse(content=jsonable_encoder(response_scheme))


@playlist_router.get(path="",
                     response_model=ResponseSchema[list[PlaylistDetailSchema]])
def get_playlist_by_ids(ids: str = Query(..., regex=AGGREGATE_ID_LIST_REGEX)):
    playlist_detail_schemas = playlist_service.get_playlist_by_aggregate_ids(
        ids.split(","))
    response = ok(data=playlist_detail_schemas)
    return JSONResponse(content=jsonable_encoder(response))
