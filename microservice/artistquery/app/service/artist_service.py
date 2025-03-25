from app.repository.artist_repository import ArtistRepository
from app.core.exception import NotFoundException
from app.mapper.artist_mapper import map_to_artist_schema
from app.core.logger import Logger
from app.schema.artist_schema import ArtistSchema


class ArtistService:

    def __init__(self, artist_repository: ArtistRepository, logger: Logger):
        self.artist_repository = artist_repository
        self.logger = logger

    def get_artist_by_aggregate_id(
            self,
            aggregate_id: str,
            isLoadImages: bool = False,
            isLoadRevisions: bool = False) -> ArtistSchema:
        artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
            aggregate_id=aggregate_id,
            isLoadImages=isLoadImages,
            isLoadRevisions=isLoadRevisions)
        if (artist is None):
            raise NotFoundException(
                f"Artist not found: aggregate_id={aggregate_id}")
        return map_to_artist_schema(artist)

    def get_artist_by_aggregate_ids(
            self,
            aggregate_ids: list[str],
            isLoadImages: bool = False,
            isLoadRevisions: bool = False) -> list[ArtistSchema]:
        artists = self.artist_repository.find_by_aggregate_ids_and_is_active_true(
            aggregate_ids=aggregate_ids,
            isLoadImages=isLoadImages,
            isLoadRevisions=isLoadRevisions)
        return [map_to_artist_schema(artist) for artist in artists]

    def get_artist_by_ref_codes(
            self,
            ref_codes: list[str],
            isLoadImages: bool = False,
            isLoadRevisions: bool = False) -> list[ArtistSchema]:
        artists = self.artist_repository.find_by_ref_codes_and_is_active_true(
            ref_codes=ref_codes,
            isLoadImages=isLoadImages,
            isLoadRevisions=isLoadRevisions)
        return [map_to_artist_schema(artist) for artist in artists]
