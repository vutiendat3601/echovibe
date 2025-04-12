from fastapi import APIRouter, Query
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.track_schema import TrackSchema
from app.schema.tag_schema import TagSchema
from app.service.track_service import TrackService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.constant.constant import AGGREGATE_ID_LIST_REGEX, AGGREGATE_REF_CODE_LIST_REGEX

track_router = APIRouter(prefix="/v1/tracks", tags=["Track"])

track_service: TrackService = Provide[Container.track_service]


@track_router.get(path="/all", response_model=ResponseSchema[list[TrackSchema]])
def get_all_tracks(load_images: bool = Query(default=False, alias="loadImages"),
                   load_revisions: bool = Query(default=False,
                                                alias="loadRevisions")):
    track_schema = track_service.get_all_tracks(
        is_load_images=load_images, is_load_revisions=load_revisions)
    response = ok(data=track_schema)
    return JSONResponse(content=jsonable_encoder(response))


@track_router.get(path="/byId/{id}", response_model=ResponseSchema[TrackSchema])
def get_track_by_id(id: str,
                    load_images: bool = Query(default=False,
                                              alias="loadImages"),
                    load_revisions: bool = Query(default=False,
                                                 alias="loadRevisions")):
    track_schema = track_service.get_track_by_aggregate_id(
        aggregate_id=id,
        is_load_images=load_images,
        is_load_revisions=load_revisions)
    response = ok(data=track_schema)
    return JSONResponse(content=jsonable_encoder(response))


@track_router.get(path="/byId",
                  response_model=ResponseSchema[list[TrackSchema]])
def get_track_by_ids(ids: str = Query(..., regex=AGGREGATE_ID_LIST_REGEX),
                     load_images: bool = Query(default=False,
                                               alias="loadImages"),
                     load_revisions: bool = Query(default=False,
                                                  alias="loadRevisions")):
    track_schemas = track_service.get_track_by_aggregate_ids(
        ids.split(","),
        is_load_images=load_images,
        is_load_revisions=load_revisions)
    response = ok(data=track_schemas)
    return JSONResponse(content=jsonable_encoder(response))


@track_router.get(path="/byRefCode",
                  response_model=ResponseSchema[list[TrackSchema]])
def get_track_by_ref_codes(ref_codes: str = Query(
    ..., alias="refCodes", regex=AGGREGATE_REF_CODE_LIST_REGEX),
                           load_images: bool = Query(default=False,
                                                     alias="loadImages"),
                           load_revisions: bool = Query(default=False,
                                                        alias="loadRevisions")):
    track_schemas = track_service.get_track_by_ref_codes(
        ref_codes.split(","),
        is_load_images=load_images,
        is_load_revisions=load_revisions)
    response = ok(data=track_schemas)
    return JSONResponse(content=jsonable_encoder(response))
