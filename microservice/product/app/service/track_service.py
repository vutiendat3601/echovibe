from app.repository.track_detail_repository import TrackDetailRepository
from app.core.exception import NotFoundException
from app.mapper.track_mapper import map_to_track_detail_schema
from app.core.logger import Logger
from app.schema.track_schema import TrackDetailSchema
from app.cache.redis import Redis
import asyncio


class TrackService:

    def __init__(self, track_detail_repository: TrackDetailRepository,
                 redis: Redis, logger: Logger):
        self.track_detail_repository = track_detail_repository
        self.redis = redis
        self.logger = logger

    async def get_track_by_aggregate_id(self,
                                        aggregate_id: str) -> TrackDetailSchema:
        # Check if the Track is in the cache
        track_cache_key = f"track:{aggregate_id}"
        track_json = await self.redis.get_value(track_cache_key)
        if track_json:
            track_detail_schema = TrackDetailSchema.model_validate_json(
                track_json)
            return track_detail_schema

        # If not in the cache, fetch from the database
        track_detail = self.track_detail_repository.find_by_aggregate_id(
            aggregate_id)

        if track_detail is None:
            raise NotFoundException(
                f"Track not found: aggregate_id={aggregate_id}")
        track_detail_schema = map_to_track_detail_schema(track_detail)
        asyncio.create_task(
            self.redis.set_value(key=track_cache_key,
                                 value=track_detail_schema.model_dump_json()))
        return track_detail_schema

    def get_track_by_aggregate_ids(
            self, aggregate_ids: list[str]) -> list[TrackDetailSchema | None]:
        track_details = self.track_detail_repository.find_by_aggregate_ids(
            aggregate_ids)
        track_detail_schemas_map = dict(
            map(
                lambda track_detail: (track_detail.aggregate_id,
                                      map_to_track_detail_schema(track_detail)),
                track_details))
        track_detail_schemas = [
            track_detail_schemas_map.get(aggregate_id)
            for aggregate_id in aggregate_ids
        ]
        return track_detail_schemas

    async def get_all_tracks_by_artist_id(
            self, artist_id: str) -> list[TrackDetailSchema | None]:
        track_details = self.track_detail_repository.find_by_artist_id(
            artist_id)
        track_detail_schemas = [
            map_to_track_detail_schema(track_detail)
            for track_detail in track_details
        ]
        return track_detail_schemas
