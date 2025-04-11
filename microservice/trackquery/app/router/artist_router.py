from fastapi import APIRouter, Query
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.artist_schema import ArtistSchema
from app.schema.tag_schema import TagSchema
from app.service.artist_service import ArtistService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.constant.constant import AGGREGATE_ID_LIST_REGEX, AGGREGATE_REF_CODE_LIST_REGEX
import json

artist_router = APIRouter(prefix="/v1/artists", tags=["Artist"])

artist_service: ArtistService = Provide[Container.artist_service]


@artist_router.get(path="/all",
                   response_model=ResponseSchema[list[ArtistSchema]])
def get_all_artists(load_images: bool = Query(default=False,
                                              alias="loadImages"),
                    load_revisions: bool = Query(default=False,
                                                 alias="loadRevisions")):
    artist_schema = artist_service.get_all_artists(
        is_load_images=load_images, is_load_revisions=load_revisions)
    response = ok(data=artist_schema)
    return JSONResponse(content=jsonable_encoder(response))


@artist_router.get(path="/byId/{id}",
                   response_model=ResponseSchema[ArtistSchema])
def get_artist_by_id(id: str,
                     load_images: bool = Query(default=False,
                                               alias="loadImages"),
                     load_revisions: bool = Query(default=False,
                                                  alias="loadRevisions")):
    artist_schema = artist_service.get_artist_by_aggregate_id(
        aggregate_id=id,
        is_load_images=load_images,
        is_load_revisions=load_revisions)
    response = ok(data=artist_schema)
    return JSONResponse(content=jsonable_encoder(response))


@artist_router.get(path="/byId",
                   response_model=ResponseSchema[list[ArtistSchema]])
def get_artist_by_ids(ids: str = Query(..., regex=AGGREGATE_ID_LIST_REGEX),
                      load_images: bool = Query(default=False,
                                                alias="loadImages"),
                      load_revisions: bool = Query(default=False,
                                                   alias="loadRevisions")):
    artist_schemas = artist_service.get_artist_by_aggregate_ids(
        ids.split(","),
        is_load_images=load_images,
        is_load_revisions=load_revisions)
    response = ok(data=artist_schemas)
    return JSONResponse(content=jsonable_encoder(response))


@artist_router.get(path="/byRefCode",
                   response_model=ResponseSchema[list[ArtistSchema]])
def get_artist_by_ref_codes(
        ref_codes: str = Query(...,
                               alias="refCodes",
                               regex=AGGREGATE_REF_CODE_LIST_REGEX),
        load_images: bool = Query(default=False, alias="loadImages"),
        load_revisions: bool = Query(default=False, alias="loadRevisions")):
    artist_schemas = artist_service.get_artist_by_ref_codes(
        ref_codes.split(","),
        is_load_images=load_images,
        is_load_revisions=load_revisions)
    response = ok(data=artist_schemas)
    return JSONResponse(content=jsonable_encoder(response))
