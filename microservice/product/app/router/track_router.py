from fastapi import APIRouter, Query, Header, Response
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.track_schema import (TrackDetailSchema)
from app.service.track_service import TrackService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.constant.constant import AGGREGATE_ID_LIST_REGEX
from app.cache.redis import Redis
from app.util.generator_util import generate_etag
import asyncio

track_router = APIRouter(prefix="/v1/tracks", tags=["Track"])

track_service: TrackService = Provide[Container.track_service]
redis: Redis = Provide[Container.redis]


@track_router.get("/{id}", response_model=ResponseSchema[TrackDetailSchema])
async def get_track_by_id(id: str):
    track_detail_schema = await track_service.get_track_by_aggregate_id(
        aggregate_id=id)
    response_scheme = ok(data=track_detail_schema)
    return JSONResponse(content=jsonable_encoder(response_scheme))


@track_router.get(path="",
                  response_model=ResponseSchema[list[TrackDetailSchema]])
async def get_track_by_ids(ids: str = Query(..., regex=AGGREGATE_ID_LIST_REGEX),
                           if_none_match: str | None = Header(
                               None, alias="If-None-Match")):
    tracks_cache_key = f"tracks:etag:{if_none_match}" if if_none_match else None
    if tracks_cache_key and await redis.exists(tracks_cache_key):
        return JSONResponse(status_code=304, content=None)
    track_detail_schemas = track_service.get_track_by_aggregate_ids(
        ids.split(","))
    response = ok(data=track_detail_schemas)
    etag = generate_etag(response.model_dump_json())
    asyncio.create_task(redis.set_value(f"tracks:etag:{etag}", etag))
    return JSONResponse(content=jsonable_encoder(response),
                        headers={"ETag": etag})


@track_router.get(path="/byArtistId/{artist_id}",
                  response_model=ResponseSchema[list[TrackDetailSchema]])
async def get_all_tracks_by_artist_id(artist_id: str):
    track_detail_schemas = await track_service.get_all_tracks_by_artist_id(
        artist_id)
    response = ok(data=track_detail_schemas)
    return JSONResponse(content=jsonable_encoder(response))
