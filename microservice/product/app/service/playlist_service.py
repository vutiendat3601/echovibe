from app.repository.playlist_detail_repository import PlaylistDetailRepository
from app.core.exception import NotFoundException
from app.mapper.playlist_mapper import map_to_playlist_detail_schema
from app.core.logger import Logger
from app.schema.playlist_schema import PlaylistDetailSchema
from app.cache.redis import Redis
import asyncio


class PlaylistService:

    def __init__(self, playlist_detail_repository: PlaylistDetailRepository,
                 redis: Redis, logger: Logger):
        self.playlist_detail_repository = playlist_detail_repository
        self.redis = redis
        self.logger = logger

    async def get_playlist_by_aggregate_id(
            self, aggregate_id: str) -> PlaylistDetailSchema:
        # Check if the Playlist is in the cache
        playlist_cache_key = f"playlist:{aggregate_id}"
        playlist_json = await self.redis.get_value(playlist_cache_key)
        if playlist_json:
            playlist_detail_schema = PlaylistDetailSchema.model_validate_json(
                playlist_json)
            return playlist_detail_schema

        # If not in the cache, fetch from the database
        playlist_detail = self.playlist_detail_repository.find_by_aggregate_id(
            aggregate_id)
        if (playlist_detail is None):
            raise NotFoundException(
                f"Playlist not found: aggregate_id={aggregate_id}")
        playlist_detail_schema = map_to_playlist_detail_schema(playlist_detail)
        asyncio.create_task(
            self.redis.set_value(
                key=playlist_cache_key,
                value=playlist_detail_schema.model_dump_json()))
        return playlist_detail_schema

    async def get_playlist_by_aggregate_ids(
            self,
            aggregate_ids: list[str]) -> list[PlaylistDetailSchema | None]:
        playlist_details = self.playlist_detail_repository.find_by_aggregate_ids(
            aggregate_ids)
        playlist_detail_schemas_map = dict(
            map(
                lambda playlist_detail:
                (playlist_detail.aggregate_id,
                 map_to_playlist_detail_schema(playlist_detail)),
                playlist_details))
        playlist_detail_schemas = [
            playlist_detail_schemas_map.get(aggregate_id)
            for aggregate_id in aggregate_ids
        ]
        return playlist_detail_schemas
