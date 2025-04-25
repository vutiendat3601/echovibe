from app.core.logger import Logger
from datetime import datetime, timezone
from app.repository.track_repository import (TrackRepository)
from app.repository.artist_repository import (ArtistRepository)
from app.event.schema.track_event_schema import (TrackReleasedEvent,
                                                 TrackDeletedEvent)
from app.model.track import (Track, TrackArtist)


class TrackEventHandler:

    def __init__(self, track_repository: TrackRepository,
                 artist_repository: ArtistRepository, logger: Logger):
        self.track_repository = track_repository
        self.artist_repository = artist_repository
        self.logger = logger

    def handle_track_released_event(self,
                                    track_released_event: TrackReleasedEvent):
        updated_at = datetime.now(timezone.utc)
        track = self.track_repository.find_by_aggregate_id_and_is_active_true(
            track_released_event.id)
        if track is None:
            track = Track()
            track.aggregate_id = track_released_event.id
            track.created_at = updated_at
            track.created_by = track_released_event.created_by
        release_detail = track_released_event.detail
        track.urn = track_released_event.urn
        track.ref_code = track_released_event.ref_code
        track.name = release_detail.name
        track.description = release_detail.description
        track.official_released_date = release_detail.official_released_date
        track.thumbnail_file_key = release_detail.thumbnail_file_key
        track.thumbnail_url = release_detail.thumbnail_url
        track.revision_number = track_released_event.revision_number
        track.is_public = track_released_event.is_public
        track.is_released = track_released_event.is_released
        track.is_active = track_released_event.is_active
        track.tags = [
            tag.name for tag in track_released_event.tags if tag.is_active
        ]
        track.event_type = track_released_event.type
        track.event_version = track_released_event.version
        track.event_timestamp = track_released_event.timestamp
        track.created_at = updated_at
        track.updated_by = track_released_event.created_by

        # Audio
        if track_released_event.track_audio is not None and track_released_event.track_audio.is_active:
            track.audio_file_m3u8_url = track_released_event.track_audio.file_m3u8_url
            track.audio_duration_second = track_released_event.track_audio.duration_second
        else:
            track.audio_file_m3u8_url = None
            track.audio_duration_second = None

        # Artist
        for track_artist in track_released_event.track_artists:
            existed_track_artist: TrackArtist = next(
                (item for item in track.track_artists
                 if item.artist_aggregate_id == track_artist.artist_id), None)
            if existed_track_artist is None:
                artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
                    track_artist.artist_id)
                if artist is not None:
                    track.track_artists.append(
                        TrackArtist(
                            aggregate_id=track_released_event.id,
                            artist_aggregate_id=track_artist.artist_id,
                            artist_id=artist.id,
                            track_aggregate_id=track.aggregate_id,
                            track_id=track.id,
                            is_active=track_artist.is_active,
                            is_main_artist=track_artist.is_main_artist,
                            event_type=track_released_event.type,
                            event_version=track_released_event.version,
                            event_timestamp=track_released_event.timestamp,
                            created_at=updated_at,
                            updated_at=updated_at,
                            created_by=track_released_event.created_by,
                            updated_by=track_released_event.created_by))
            else:
                existed_track_artist.track_id = track.id
                existed_track_artist.artist_id = artist.id
                existed_track_artist.track_aggregate_id = track.aggregate_id
                existed_track_artist.artist_aggregate_id = artist.aggregate_id
                existed_track_artist.is_active = track_artist.is_active
                existed_track_artist.is_main_artist = track_artist.is_main_artist
                existed_track_artist.event_type = track_released_event.type
                existed_track_artist.event_version = track_released_event.version
                existed_track_artist.event_timestamp = track_released_event.timestamp
                existed_track_artist.updated_at = updated_at
                existed_track_artist.updated_by = track_released_event.created_by
        self.track_repository.save_track(track)
        self.logger.info(
            f"Processed {TrackReleasedEvent.__name__}: id={track_released_event.id}, version={track_released_event.version}"
        )

    def handle_track_deleted_event(self,
                                   track_deleted_event: TrackDeletedEvent):
        if track_deleted_event.is_soft_deleted:
            track = self.track_repository.find_by_aggregate_id_and_is_active_true(
                track_deleted_event.id)
            if track is not None:
                track.is_active = track_deleted_event.is_active
                track.event_type = track_deleted_event.type
                track.event_version = track_deleted_event.version
                track.event_timestamp = track_deleted_event.timestamp
                track.updated_at = datetime.now(timezone.utc)
                self.track_repository.save_track(track)
        else:
            self.track_repository.delete_by_aggregate_id(track_deleted_event.id)
        self.logger.info(
            f"Processed {TrackDeletedEvent.__name__}: id={track_deleted_event.id}, version={track_deleted_event.version}, timestamp={track_deleted_event.timestamp}"
        )
