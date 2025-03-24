from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.repository.artist_repository import ArtistRepository
from app.core.exception import NotFoundException
from app.mapper.artist_mapper import map_to_artist_schema
from app.core.logger import Logger


class ArtistService:

    def __init__(self, artist_repository: ArtistRepository, logger: Logger):
        self.artist_repository = artist_repository
        self.logger = logger

    def get_artist_by_aggregate_id(self, aggregate_id: str):
        artist = self.artist_repository.find_by(aggregate_id)
        if (artist is None):
            raise NotFoundException(
                f"Artist not found: aggregate_id={aggregate_id}")
        artist_schema = map_to_artist_schema(artist)
        return JSONResponse(content=jsonable_encoder(artist_schema))

    def get_artist_by_aggregate_ids(self, aggregate_ids: list[str]):
        artists = self.artist_repository.find_by_aggregate_ids_and_is_active_true(aggregate_ids)
        artist_schemas = [map_to_artist_schema(artist) for artist in artists]
        return artist_schemas

    def get_artist_by_ref_codes(self, ref_codes: list[str]):
        artists = self.artist_repository.find_by_ref_codes_and_is_active_true(ref_codes)
        artist_schemas = [map_to_artist_schema(artist) for artist in artists]
        return artist_schemas
