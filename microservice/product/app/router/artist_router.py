from fastapi import APIRouter, Query
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.artist_schema import (ArtistDetailSchema)
from app.service.artist_service import ArtistService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.constant.constant import AGGREGATE_ID_LIST_REGEX

artist_router = APIRouter(prefix="/v1/artists", tags=["Artist"])

artist_service: ArtistService = Provide[Container.artist_service]


@artist_router.get("/{id}", response_model=ResponseSchema[ArtistDetailSchema])
def get_artist_by_id(id: str):
    artist_detail_schema = artist_service.get_artist_by_aggregate_id(
        aggregate_id=id)
    response_scheme = ok(data=artist_detail_schema)
    return JSONResponse(content=jsonable_encoder(response_scheme))


@artist_router.get(path="",
                   response_model=ResponseSchema[list[ArtistDetailSchema]])
def get_artist_by_ids(ids: str = Query(..., regex=AGGREGATE_ID_LIST_REGEX)):
    artist_detail_schemas = artist_service.get_artist_by_aggregate_ids(
        ids.split(","))
    response = ok(data=artist_detail_schemas)
    return JSONResponse(content=jsonable_encoder(response))
