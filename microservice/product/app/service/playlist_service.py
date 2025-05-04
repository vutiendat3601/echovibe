from app.repository.playlist_detail_repository import PlaylistDetailRepository
from app.core.exception import NotFoundException
from app.mapper.playlist_mapper import map_to_playlist_detail_schema
from app.core.logger import Logger
from app.schema.playlist_schema import PlaylistDetailSchema


class PlaylistService:

    def __init__(self, playlist_detail_repository: PlaylistDetailRepository,
                 logger: Logger):
        self.playlist_detail_repository = playlist_detail_repository
        self.logger = logger

    def get_playlist_by_aggregate_id(self,
                                     aggregate_id: str) -> PlaylistDetailSchema:
        playlist_detail = self.playlist_detail_repository.find_by_aggregate_id(
            aggregate_id)
        if (playlist_detail is None):
            raise NotFoundException(
                f"Playlist not found: aggregate_id={aggregate_id}")
        return map_to_playlist_detail_schema(playlist_detail)

    def get_playlist_by_aggregate_ids(
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
