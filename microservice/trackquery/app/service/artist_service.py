from app.repository.artist_repository import ArtistRepository
from app.core.exception import NotFoundException
from app.mapper.artist_mapper import map_to_artist_schema
from app.core.logger import Logger
from app.schema.artist_schema import ArtistSchema


class ArtistService:

    def __init__(self, artist_repository: ArtistRepository, logger: Logger):
        self.artist_repository = artist_repository
        self.logger = logger

    def get_all_artists(self,
                        is_load_images: bool = False,
                        is_load_revisions: bool = False) -> ArtistSchema:
        artists = self.artist_repository.find_all_by_is_active_true(
            is_load_images=is_load_images, is_load_revisions=is_load_revisions)

        return [
            map_to_artist_schema(artist, is_load_images, is_load_revisions)
            for artist in artists
        ]

    def get_artist_by_aggregate_id(
            self,
            aggregate_id: str,
            is_load_images: bool = False,
            is_load_revisions: bool = False) -> ArtistSchema:
        artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
            aggregate_id=aggregate_id,
            is_load_images=is_load_images,
            is_load_revisions=is_load_revisions)
        if (artist is None):
            raise NotFoundException(
                f"Artist not found: aggregate_id={aggregate_id}")
        return map_to_artist_schema(artist, is_load_images, is_load_revisions)

    def get_artist_by_aggregate_ids(
            self,
            aggregate_ids: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = False) -> list[ArtistSchema | None]:
        artists = self.artist_repository.find_by_aggregate_ids_and_is_active_true(
            aggregate_ids=aggregate_ids,
            is_load_images=is_load_images,
            is_load_revisions=is_load_revisions)
        artist_schemas_map = dict(
            map(
                lambda artist: (artist.aggregate_id,
                                map_to_artist_schema(artist, is_load_images,
                                                     is_load_revisions)),
                artists))
        return [
            artist_schemas_map.get(aggregate_id)
            for aggregate_id in aggregate_ids
        ]

    def get_artist_by_ref_codes(
            self,
            ref_codes: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = False) -> list[ArtistSchema]:
        artists = self.artist_repository.find_by_ref_codes_and_is_active_true(
            ref_codes=ref_codes,
            is_load_images=is_load_images,
            is_load_revisions=is_load_revisions)
        artist_schemas_map = dict(
            map(
                lambda artist: (artist.ref_code,
                                map_to_artist_schema(artist, is_load_images,
                                                     is_load_revisions)),
                artists))
        return [artist_schemas_map.get(ref_code) for ref_code in ref_codes]
