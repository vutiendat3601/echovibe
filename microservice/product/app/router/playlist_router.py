from fastapi import APIRouter, Query, Header
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.playlist_schema import (PlaylistDetailSchema)
from app.service.playlist_service import PlaylistService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.constant.constant import AGGREGATE_ID_LIST_REGEX
from app.cache.redis import Redis
from app.util.generator_util import generate_etag
import asyncio

playlist_router = APIRouter(prefix="/v1/playlists", tags=["Track"])

playlist_service: PlaylistService = Provide[Container.playlist_service]
redis: Redis = Provide[Container.redis]


@playlist_router.get("/{id}",
                     response_model=ResponseSchema[PlaylistDetailSchema])
async def get_playlist_by_id(id: str):
    playlist_detail_schema = await playlist_service.get_playlist_by_aggregate_id(
        aggregate_id=id)
    response_scheme = ok(data=playlist_detail_schema)
    return JSONResponse(content=jsonable_encoder(response_scheme))


@playlist_router.get(path="",
                     response_model=ResponseSchema[list[PlaylistDetailSchema]])
async def get_playlist_by_ids(ids: str = Query(...,
                                               regex=AGGREGATE_ID_LIST_REGEX),
                              if_none_match: str |
                              None = Header(alias="If-None-Match")):
    playlists_cache_key = f"playlists:etag:{if_none_match}" if if_none_match else None
    if playlists_cache_key and await redis.exists(playlists_cache_key):
        return JSONResponse(status_code=304, content=None)
    playlist_detail_schemas = await playlist_service.get_playlist_by_aggregate_ids(
        ids.split(","))
    response = ok(data=playlist_detail_schemas)
    etag = generate_etag(response.model_dump_json())
    asyncio.create_task(redis.set_value(f"playlists:etag:{etag}", etag))
    return JSONResponse(content=jsonable_encoder(response))
