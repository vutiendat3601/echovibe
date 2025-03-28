from app.core.logger import Logger
from datetime import datetime, timezone
from app.repository.impl.sqlmodel_artist_repository import ArtistRepository
from app.event.schema.artist_event_schema import (ArtistCreatedEvent,
                                                  ArtistReleasedEvent,
                                                  ArtistUpdatedEvent,
                                                  ArtistDeletedEvent,
                                                  ArtistVerificationSetEvent)
from app.model.artist import (Artist, ArtistProfile, ArtistImage,
                              ArtistRevision)
from app.enum.artist_image_type import ArtistImageType


class ArtistEventHandler:

    def __init__(self, artist_repository: ArtistRepository, logger: Logger):
        self.artist_repository = artist_repository
        self.logger = logger

    def handle_artist_created_event(self,
                                    artist_created_event: ArtistCreatedEvent):
        created_at = datetime.now(timezone.utc)

        # Artist, ArtistProfile
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
        artist_attributes = {
            **artist_created_event.model_dump(), "id": None,
            "tags": [
                tag.name for tag in artist_created_event.tags if tag.is_active
            ],
            "tags_json": [
                tag.model_dump(by_alias=True)
                for tag in artist_created_event.tags
            ],
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
        artist = Artist(**artist_attributes)

        # ArtistImage thumbnail
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

        # ArtistImage background
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
            f"Processed {ArtistCreatedEvent.__name__}: id={artist_created_event.id}, version={artist_created_event.version}"
        )

    def handle_artist_released_event(
            self, artist_released_event: ArtistReleasedEvent):
        updated_at = datetime.now(timezone.utc)
        artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
            artist_released_event.id)
        if artist is not None:
            if artist.profile is None:
                artist.profile = ArtistProfile()
            # Update Artist, ArtistProfile
            release_profile = artist_released_event.profile
            artist.urn = artist_released_event.urn
            artist.profile.name = release_profile.name
            artist.profile.biography = release_profile.biography
            artist.profile.description = release_profile.description
            artist.profile.thumbnail_file_key = release_profile.thumbnail_file_key
            artist.profile.thumbnail_url = release_profile.thumbnail_url
            artist.profile.background_file_key = release_profile.background_file_key
            artist.profile.background_url = release_profile.background_url
            artist.is_released = artist_released_event.is_released
            artist.ref_code = artist_released_event.ref_code
            artist.is_public = artist_released_event.is_public
            artist.is_active = artist_released_event.is_active
            artist.is_verified = artist_released_event.is_verified
            artist.tags = [
                tag.name for tag in artist_released_event.tags if tag.is_active
            ]
            artist.tags_json = [
                tag.model_dump(by_alias=True)
                for tag in artist_released_event.tags
            ]
            artist.event_type = artist_released_event.type
            artist.event_version = artist_released_event.version
            artist.event_timestamp = artist_released_event.timestamp
            artist.updated_at = updated_at

            # Revision
            revision_attributes = {
                **artist_released_event.model_dump(),
                "id": None,
                "artist_id": artist.id,
                "aggregate_id": artist.aggregate_id,
                "name": artist.profile.name,
                "tags_json": [
                    tag.model_dump(by_alias=True)
                    for tag in artist_released_event.tags
                ],
                "tags": [
                    tag.name
                    for tag in artist_released_event.tags
                    if tag.is_active
                ],
                "number": artist.revision_number + 1,
                "description": artist.profile.description,
                "biography": artist.profile.biography,
                "nationality_iso_code": artist.profile.nationality_iso_code,
                "thumbnail_url": artist.profile.thumbnail_url,
                "thumbnail_file_key": artist.profile.thumbnail_file_key,
                "background_url": artist.profile.background_url,
                "background_file_key": artist.profile.background_file_key,
                "event_type": artist.event_type,
                "event_version": artist.event_version,
                "event_timestamp": artist.event_timestamp,
                "created_at": artist.created_at,
                "updated_at": artist.updated_at,
                "created_by": artist.created_by,
                "updated_by": artist.updated_by,
            }
            revision = ArtistRevision(**revision_attributes)
            artist.revisions.append(revision)

            self.artist_repository.save_artist(artist)
        self.logger.info(
            f"Processed {ArtistReleasedEvent.__name__}: id={artist_released_event.id}, version={artist_released_event.version}"
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
            artist.tags = [
                tag.name for tag in artist_updated_event.tags if tag.is_active
            ]
            artist.tags_json = [
                tag.model_dump(by_alias=True)
                for tag in artist_updated_event.tags
            ]
            artist.is_public = artist_updated_event.is_public
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
            f"Processed {ArtistUpdatedEvent.__name__}: id={artist_updated_event.id}, version={artist_updated_event.version}, timestamp={artist_updated_event.timestamp}"
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
            f"Processed {ArtistDeletedEvent.__name__}: id={artist_deleted_event.id}, version={artist_deleted_event.version}, timestamp={artist_deleted_event.timestamp}"
        )

    def handle_artist_verification_set_event(
            self, artist_verification_set_event: ArtistVerificationSetEvent):
        updated_at = datetime.now(timezone.utc)
        artist = self.artist_repository.find_by_aggregate_id_and_is_active_true(
            artist_verification_set_event.id)
        if artist is not None:
            artist.is_verified = artist_verification_set_event.is_verified
            artist.event_timestamp = artist_verification_set_event.timestamp
            artist.event_type = artist_verification_set_event.type
            artist.event_version = artist_verification_set_event.version
            artist.updated_at = updated_at
            self.artist_repository.save_artist(artist)
        self.logger.info(
            f"Processed {ArtistVerificationSetEvent.__name__}: id={artist_verification_set_event.id}, version={artist_verification_set_event.version}, timestamp={artist_verification_set_event.timestamp}"
        )
