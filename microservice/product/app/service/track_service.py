from app.repository.track_detail_repository import TrackDetailRepository
from app.core.exception import NotFoundException
from app.mapper.track_mapper import map_to_track_detail_schema
from app.core.logger import Logger
from app.schema.track_schema import TrackDetailSchema


class TrackService:

    def __init__(self, track_detail_repository: TrackDetailRepository,
                 logger: Logger):
        self.track_detail_repository = track_detail_repository
        self.logger = logger

    def get_track_by_aggregate_id(self, aggregate_id: str) -> TrackDetailSchema:
        track_detail = self.track_detail_repository.find_by_aggregate_id(
            aggregate_id)
        if (track_detail is None):
            raise NotFoundException(
                f"Track not found: aggregate_id={aggregate_id}")
        return map_to_track_detail_schema(track_detail)

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
