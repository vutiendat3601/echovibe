from fastapi import APIRouter, Depends, HTTPException, Query
from typing import List, Optional, Annotated
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema import artist_schema
from app.service.artist_service import ArtistService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok

from http import HTTPStatus

artist_router = APIRouter(prefix="/v1/artists", tags=["Artist"])

artist_service: ArtistService = Provide[Container.artist_service]


@artist_router.get(
    "", response_model=ResponseSchema[list[artist_schema.ArtistSchema]])
def get_artist_by_ids(ids: Annotated[list[str], Query()]):
    artist_schemas = artist_service.get_artist_by_aggregate_ids(ids)
    response = ok(data=artist_schemas)
    return JSONResponse(content=jsonable_encoder(response))
