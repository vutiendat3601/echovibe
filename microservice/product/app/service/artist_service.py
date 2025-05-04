from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.repository.artist_detail_repository import ArtistDetailRepository
from app.core.exception import NotFoundException
from app.mapper.artist_mapper import map_to_artist_detail_schema
from app.core.logger import Logger
from app.schema.artist_schema import ArtistDetailSchema
from app.cache.redis import Redis
import asyncio


class ArtistService:

    def __init__(self, artist_detail_repository: ArtistDetailRepository,
                 redis: Redis, logger: Logger):
        self.artist_detail_repository = artist_detail_repository
        self.redis = redis
        self.logger = logger

    async def get_artist_by_aggregate_id(
            self, aggregate_id: str) -> ArtistDetailSchema:
        # Check if the Track is in the cache
        artist_cache_key = f"artist:{aggregate_id}"
        artist_json = await self.redis.get_value(artist_cache_key)
        if artist_json:
            artist_detail_schema = ArtistDetailSchema.model_validate_json(
                artist_json)
            return artist_detail_schema

        # If not in the cache, fetch from the database
        artist_detail = self.artist_detail_repository.find_by_aggregate_id(
            aggregate_id)
        if (artist_detail is None):
            raise NotFoundException(
                f"Artist not found: aggregate_id={aggregate_id}")
        artist_detail_schema = map_to_artist_detail_schema(artist_detail)
        asyncio.create_task(
            self.redis.set_value(key=artist_cache_key,
                                 value=artist_detail_schema.model_dump_json()))
        return artist_detail_schema

    async def get_artist_by_aggregate_ids(
            self, aggregate_ids: list[str]) -> list[ArtistDetailSchema | None]:
        artist_details = self.artist_detail_repository.find_by_aggregate_ids(
            aggregate_ids)
        artist_detail_schemas_map = dict(
            map(
                lambda artist_detail:
                (artist_detail.aggregate_id,
                 map_to_artist_detail_schema(artist_detail)), artist_details))
        artist_detail_schemas = [
            artist_detail_schemas_map.get(aggregate_id)
            for aggregate_id in aggregate_ids
        ]
        return artist_detail_schemas
