from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.repository.artist_detail_repository import ArtistDetailRepository
from app.core.exception import NotFoundException
from app.mapper.artist_mapper import map_to_artist_detail_schema
from app.core.logger import Logger
from app.schema.artist_schema import ArtistDetailScheme


class ArtistService:

    def __init__(self, artist_detail_repository: ArtistDetailRepository,
                 logger: Logger):
        self.artist_detail_repository = artist_detail_repository
        self.logger = logger

    def get_artist_by_aggregate_id(self,
                                   aggregate_id: str) -> ArtistDetailScheme:
        artist_detail = self.artist_detail_repository.find_by_aggregate_id(
            aggregate_id)
        if (artist_detail is None):
            raise NotFoundException(
                f"Artist not found: aggregate_id={aggregate_id}")
        return map_to_artist_detail_schema(artist_detail)

    def get_artist_by_aggregate_ids(
            self, aggregate_ids: list[str]) -> list[ArtistDetailScheme | None]:
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
