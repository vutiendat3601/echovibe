from app.core.logger import Logger
from datetime import datetime, timezone
from app.repository.impl.sqlmodel_artist_repository import ArtistRepository
from app.event.schema.artist_event_schema import (ArtistCreatedEvent,
                                                  ArtistReleasedEvent,
                                                  ArtistUpdatedEvent,
                                                  ArtistDeletedEvent,
                                                  ArtistVerificationSetEvent)
from app.model.artist import Artist, ArtistProfile, ArtistImage
from app.enum.artist_image_type import ArtistImageType


class ArtistEventHandler:

    def __init__(self, artist_repository: ArtistRepository, logger: Logger):
        self.artist_repository = artist_repository
        self.logger = logger

    def handle_artist_created_event(self,
                                    artist_created_event: ArtistCreatedEvent):
        created_at = datetime.now(timezone.utc)
        artist_profile_attributes = {
            **artist_created_event.profile.model_dump(), "id": None,
            "aggregate_id": artist_created_event.id,
            "artist_ref_code": artist_created_event.ref_code,
            "event_type": artist_created_event.type,
            "event_version": artist_created_event.version,
            "event_timestamp": artist_created_event.timestamp,
            "created_at": created_at,
            "updated_at": created_at,
            "created_by": artist_created_event.created_by,
            "updated_by": artist_created_event.created_by
        }
        artist_profile = ArtistProfile(**artist_profile_attributes)

        artist_props = {
            **artist_created_event.model_dump(), "id": None,
            "images": [],
            "profile": artist_profile,
            "aggregate_id": artist_created_event.id,
            "event_type": artist_created_event.type,
            "event_version": artist_created_event.version,
            "event_timestamp": artist_created_event.timestamp,
            "created_at": created_at,
            "updated_at": created_at,
            "created_by": artist_created_event.created_by,
            "updated_by": artist_created_event.created_by
        }
        artist = Artist(**artist_props)
        if artist_created_event.profile.thumbnail_url is not None:
            artist.images.append(
                ArtistImage(file_url=artist_created_event.profile.thumbnail_url,
                            artist_ref_code=artist_created_event.ref_code,
                            type=ArtistImageType.THUMBNAIL,
                            aggregate_id=artist_created_event.id,
                            event_type=artist_created_event.type,
                            event_version=artist_created_event.version,
                            event_timestamp=artist_created_event.timestamp,
                            created_at=created_at,
                            updated_at=created_at,
                            created_by=artist_created_event.created_by,
                            updated_by=artist_created_event.created_by))
        if artist_created_event.profile.background_url is not None:
            artist.images.append(
                ArtistImage(
                    file_url=artist_created_event.profile.background_url,
                    artist_ref_code=artist_created_event.ref_code,
                    type=ArtistImageType.BACKGROUND,
                    aggregate_id=artist_created_event.id,
                    event_type=artist_created_event.type,
                    event_version=artist_created_event.version,
                    event_timestamp=artist_created_event.timestamp,
                    created_at=created_at,
                    updated_at=created_at,
                    created_by=artist_created_event.created_by,
                    updated_by=artist_created_event.created_by))
        self.artist_repository.save_artist(artist)
        self.logger.info(
            f"Processed ArtistCreatedEvent: id={artist_created_event.id}, version={artist_created_event.version}"
        )

    def handle_artist_released_event(
            self, artist_released_event: ArtistReleasedEvent):
        updated_at = datetime.now(timezone.utc)
        artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
            artist_released_event.id)
        if artist is not None:
            if artist.profile is None:
                artist.profile = ArtistProfile()
            artist.urn = artist_released_event.urn
            artist.profile.name = artist_released_event.profile.name
            artist.profile.biography = artist_released_event.profile.biography
            artist.profile.description = artist_released_event.profile.description
            artist.is_released = artist_released_event.is_released
            artist.is_public = artist_released_event.is_public
            artist.is_active = artist_released_event.is_active
            artist.is_verified = artist_released_event.is_verified
            artist.profile.thumbnail_file_key = artist_released_event.profile.thumbnail_file_key
            artist.profile.thumbnail_url = artist_released_event.profile.thumbnail_url
            artist.profile.background_file_key = artist_released_event.profile.background_file_key
            artist.profile.background_url = artist_released_event.profile.background_url
            artist.tags = artist_released_event.tags
            artist.event_type = artist_released_event.type
            artist.event_version = artist_released_event.version
            artist.event_timestamp = artist_released_event.timestamp
            artist.updated_at = updated_at
            self.artist_repository.save_artist(artist)
        self.logger.info(
            f"Processed ArtistReleasedEvent: id={artist_released_event.id}, version={artist_released_event.version}"
        )

    def handle_artist_updated_event(self,
                                    artist_updated_event: ArtistUpdatedEvent):
        updated_at = datetime.now(timezone.utc)
        artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
            artist_updated_event.id)
        if artist is not None:
            if artist.profile is None:
                artist.profile = ArtistProfile()
            artist.profile.name = artist_updated_event.profile.name
            artist.profile.biography = artist_updated_event.profile.biography
            artist.profile.description = artist_updated_event.profile.description
            artist.profile.thumbnail_file_key = artist_updated_event.profile.thumbnail_file_key
            artist.profile.thumbnail_url = artist_updated_event.profile.thumbnail_url
            artist.profile.background_file_key = artist_updated_event.profile.background_file_key
            artist.profile.background_url = artist_updated_event.profile.background_url
            artist.event_type = artist_updated_event.type
            artist.event_timestamp = artist_updated_event.timestamp
            artist.event_version = artist_updated_event.version
            artist.updated_at = updated_at
            self.artist_repository.save_artist(artist)
        self.logger.info(
            f"Processed ArtistUpdatedEvent: id={artist_updated_event.id}, version={artist_updated_event.version}, timestamp={artist_updated_event.timestamp}"
        )

    def handle_artist_deleted_event(self,
                                    artist_deleted_event: ArtistDeletedEvent):
        updated_at = datetime.now(timezone.utc)
        if artist_deleted_event.is_soft_deleted:
            artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
                artist_deleted_event.id)
            if artist is not None:
                artist.is_active = artist_deleted_event.is_active
                artist.event_type = artist_deleted_event.type
                artist.event_version = artist_deleted_event.version
                artist.event_timestamp = artist_deleted_event.timestamp
                artist.updated_at = updated_at
                self.artist_repository.save_artist(artist)
        else:
            self.artist_repository.delete_artist(artist_deleted_event.id)
        self.logger.info(
            f"Processed ArtistDeletedEvent: id={artist_deleted_event.id}, version={artist_deleted_event.version}, timestamp={artist_deleted_event.timestamp}"
        )

    def handle_artist_verification_set_event(
            self, artist_verification_set_event: ArtistVerificationSetEvent):
        updated_at = datetime.now(timezone.utc)
        artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
            artist_verification_set_event.id)
        if artist is not None:
            artist.is_public = artist_verification_set_event.is_public
            artist.event_timestamp = artist_verification_set_event.timestamp
            artist.event_type = artist_verification_set_event.type
            artist.event_version = artist_verification_set_event.version
            artist.updated_at = updated_at
            self.artist_repository.save_artist(artist)
        self.logger.info(
            f"Processed ArtistVerificationSetEvent: id={artist_verification_set_event.id}, version={artist_verification_set_event.version}, timestamp={artist_verification_set_event.timestamp}"
        )
