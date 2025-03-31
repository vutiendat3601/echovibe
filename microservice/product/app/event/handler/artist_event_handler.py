from app.core.logger import Logger
from datetime import datetime, timezone
from app.repository.impl.sqlmodel_artist_repository import ArtistRepository
from app.event.schema.artist_event_schema import (ArtistReleasedEvent,
                                                  ArtistDeletedEvent)
from app.model.artist import (Artist)


class ArtistEventHandler:

    def __init__(self, artist_repository: ArtistRepository, logger: Logger):
        self.artist_repository = artist_repository
        self.logger = logger

    def handle_artist_released_event(
            self, artist_released_event: ArtistReleasedEvent):
        updated_at = datetime.now(timezone.utc)
        artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
            artist_released_event.id)
        if artist is None:
            artist = Artist()
            artist.aggregate_id = artist_released_event.id
            artist.created_at = updated_at
            artist.created_by = artist_released_event.created_by

        release_profile = artist_released_event.profile

        artist.urn = artist_released_event.urn
        artist.ref_code = artist_released_event.ref_code
        artist.name = release_profile.name
        artist.description = release_profile.description
        artist.biography = release_profile.biography
        artist.nationality_iso_code = release_profile.nationality_iso_code
        artist.thumbnail_file_key = release_profile.thumbnail_file_key
        artist.thumbnail_url = release_profile.thumbnail_url
        artist.background_file_key = release_profile.background_file_key
        artist.background_url = release_profile.background_url
        artist.revision_number = artist_released_event.revision_number
        artist.is_public = artist_released_event.is_public
        artist.is_released = artist_released_event.is_released
        artist.is_verified = artist_released_event.is_verified
        artist.is_active = artist_released_event.is_active
        artist.tags = [
            tag.name for tag in artist_released_event.tags if tag.is_active
        ]
        artist.event_type = artist_released_event.type
        artist.event_version = artist_released_event.version
        artist.event_timestamp = artist_released_event.timestamp
        artist.created_at = updated_at
        artist.updated_by = artist_released_event.created_by

        self.artist_repository.save_artist(artist)
        self.logger.info(
            f"Processed {ArtistReleasedEvent.__name__}: id={artist_released_event.id}, version={artist_released_event.version}"
        )

    def handle_artist_deleted_event(self,
                                    artist_deleted_event: ArtistDeletedEvent):
        if artist_deleted_event.is_soft_deleted:
            artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
                artist_deleted_event.id)
            if artist is not None:
                artist.is_active = artist_deleted_event.is_active
                artist.event_type = artist_deleted_event.type
                artist.event_version = artist_deleted_event.version
                artist.event_timestamp = artist_deleted_event.timestamp
                artist.updated_at = datetime.now(timezone.utc)
                self.artist_repository.save_artist(artist)
        else:
            self.artist_repository.delete_by_aggregate_id(
                artist_deleted_event.id)
        self.logger.info(
            f"Processed {ArtistDeletedEvent.__name__}: id={artist_deleted_event.id}, version={artist_deleted_event.version}, timestamp={artist_deleted_event.timestamp}"
        )
