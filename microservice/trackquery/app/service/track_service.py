from app.repository.track_repository import TrackRepository
from app.core.exception import NotFoundException
from app.mapper.track_mapper import map_to_track_schema
from app.core.logger import Logger
from app.schema.track_schema import TrackSchema
from app.model.track import Track


class TrackService:

    def __init__(self, track_repository: TrackRepository, logger: Logger):
        self.track_repository = track_repository
        self.logger = logger

    def get_all_tracks(self,
                       is_load_images: bool = False,
                       is_load_revisions: bool = False) -> TrackSchema:
        tracks = self.track_repository.find_all_by_is_active_true(
            is_load_images=is_load_images, is_load_revisions=is_load_revisions)

        return [
            map_to_track_schema(track, is_load_images, is_load_revisions)
            for track in tracks
        ]

    def get_track_by_aggregate_id(
            self,
            aggregate_id: str,
            is_load_images: bool = False,
            is_load_revisions: bool = False) -> TrackSchema:
        track = self.track_repository.find_by_aggregate_id_and_is_active_true(
            aggregate_id=aggregate_id,
            is_load_images=is_load_images,
            is_load_revisions=is_load_revisions)
        if (track is None):
            raise NotFoundException(
                f"track not found: aggregate_id={aggregate_id}")
        return map_to_track_schema(track, is_load_images, is_load_revisions)

    def get_track_by_aggregate_ids(
            self,
            aggregate_ids: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = False) -> list[TrackSchema | None]:
        tracks: list[Track] = self.track_repository.find_by_aggregate_ids_and_is_active_true(
            aggregate_ids=aggregate_ids,
            is_load_images=is_load_images,
            is_load_revisions=is_load_revisions)
        track_schemas_map = dict(
            map(
                lambda track:
                (track.aggregate_id,
                 map_to_track_schema(track, is_load_images, is_load_revisions)),
                tracks))
        return [
            track_schemas_map.get(aggregate_id)
            for aggregate_id in aggregate_ids
        ]

    def get_track_by_ref_codes(
            self,
            ref_codes: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = False) -> list[TrackSchema]:
        tracks = self.track_repository.find_by_ref_codes_and_is_active_true(
            ref_codes=ref_codes,
            is_load_images=is_load_images,
            is_load_revisions=is_load_revisions)
        track_schemas_map = dict(
            map(
                lambda track:
                (track.ref_code,
                 map_to_track_schema(track, is_load_images, is_load_revisions)),
                tracks))
        return [track_schemas_map.get(ref_code) for ref_code in ref_codes]
