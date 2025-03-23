from fastapi import APIRouter, Depends, HTTPException, Query
from typing import List, Optional, Annotated
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema import artist_schema
from app.service.artist_service import ArtistService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.constant.constant import AGGREGATE_ID_LIST_REGEX, AGGREGATE_REF_CODE_LIST_REGEX

artist_router = APIRouter(prefix="/v1/artists", tags=["Artist"])

artist_service: ArtistService = Provide[Container.artist_service]


@artist_router.get(
    path="/byId",
    response_model=ResponseSchema[list[artist_schema.ArtistSchema]])
def get_artist_by_ids(ids: str = Query(..., regex=AGGREGATE_ID_LIST_REGEX)):
    artist_schemas = artist_service.get_artist_by_aggregate_ids(ids.split(","))
    response = ok(data=artist_schemas)
    return JSONResponse(content=jsonable_encoder(response))


@artist_router.get(
    path="/byRefCode",
    response_model=ResponseSchema[list[artist_schema.ArtistSchema]])
def get_artist_by_ref_codes(ref_codes: str = Query(
    ..., alias="refCodes", regex=AGGREGATE_REF_CODE_LIST_REGEX)):
    artist_schemas = artist_service.get_artist_by_ref_codes(
        ref_codes.split(","))
    response = ok(data=artist_schemas)
    return JSONResponse(content=jsonable_encoder(response))
