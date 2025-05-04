from fastapi import APIRouter, Query, Header
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.artist_schema import (ArtistDetailSchema)
from app.service.artist_service import ArtistService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.constant.constant import AGGREGATE_ID_LIST_REGEX
from app.cache.redis import Redis
from app.util.generator_util import generate_etag
import asyncio

artist_router = APIRouter(prefix="/v1/artists", tags=["Artist"])

artist_service: ArtistService = Provide[Container.artist_service]
redis: Redis = Provide[Container.redis]


@artist_router.get("/{id}", response_model=ResponseSchema[ArtistDetailSchema])
async def get_artist_by_id(id: str):
    artist_detail_schema = await artist_service.get_artist_by_aggregate_id(
        aggregate_id=id)
    response_scheme = ok(data=artist_detail_schema)
    return JSONResponse(content=jsonable_encoder(response_scheme))


@artist_router.get(path="",
                   response_model=ResponseSchema[list[ArtistDetailSchema]])
async def get_artist_by_ids(
        ids: str = Query(..., regex=AGGREGATE_ID_LIST_REGEX),
        if_none_match: str | None = Header(alias="If-None-Match")):
    artists_cache_key = f"artists:etag:{if_none_match}" if if_none_match else None
    if artists_cache_key and await redis.exists(artists_cache_key):
        return JSONResponse(status_code=304, content=None)
    artist_detail_schemas = artist_service.get_artist_by_aggregate_ids(
        ids.split(","))
    response = ok(data=artist_detail_schemas)
    etag = generate_etag(response.model_dump_json())
    asyncio.create_task(redis.set_value(f"artists:etag:{etag}", etag))
    return JSONResponse(content=jsonable_encoder(response))
