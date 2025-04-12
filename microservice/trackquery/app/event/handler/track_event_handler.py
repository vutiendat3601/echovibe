from app.core.logger import Logger
from datetime import datetime, timezone
from app.repository.impl.sqlmodel_track_repository import TrackRepository
from app.event.schema.track_event_schema import (TrackCreatedEvent,
                                                 TrackReleasedEvent,
                                                 TrackUpdatedEvent,
                                                 TrackDeletedEvent,
                                                 TrackVerificationSetEvent)
from app.model.track import (Track, TrackDetail, TrackImage, TrackRevision)
from app.enum.track_image_type import TrackImageType


class TrackEventHandler:

    def __init__(self, track_repository: TrackRepository, logger: Logger):
        self.track_repository = track_repository
        self.logger = logger

    def handle_track_created_event(self,
                                   track_created_event: TrackCreatedEvent):
        created_at = datetime.now(timezone.utc)

        # Track, TrackDetail
        track_detail_attributes = {
            **track_created_event.detail.model_dump(), "id": None,
            "aggregate_id": track_created_event.id,
            "track_ref_code": track_created_event.ref_code,
            "event_type": track_created_event.type,
            "event_version": track_created_event.version,
            "event_timestamp": track_created_event.timestamp,
            "created_at": created_at,
            "updated_at": created_at,
            "created_by": track_created_event.created_by,
            "updated_by": track_created_event.created_by
        }
        track_detail = TrackDetail(**track_detail_attributes)
        track_attributes = {
            **track_created_event.model_dump(), "id": None,
            "tags": [
                tag.name for tag in track_created_event.tags if tag.is_active
            ],
            "tags_json": [
                tag.model_dump(by_alias=True)
                for tag in track_created_event.tags
            ],
            "images": [],
            "detail": track_detail,
            "aggregate_id": track_created_event.id,
            "event_type": track_created_event.type,
            "event_version": track_created_event.version,
            "event_timestamp": track_created_event.timestamp,
            "created_at": created_at,
            "updated_at": created_at,
            "created_by": track_created_event.created_by,
            "updated_by": track_created_event.created_by
        }
        track = Track(**track_attributes)

        # TrackImage thumbnail
        if track_created_event.detail.thumbnail_url is not None:
            track.images.append(
                TrackImage(file_url=track_created_event.detail.thumbnail_url,
                           Track_ref_code=track_created_event.ref_code,
                           type=TrackImageType.THUMBNAIL,
                           aggregate_id=track_created_event.id,
                           event_type=track_created_event.type,
                           event_version=track_created_event.version,
                           event_timestamp=track_created_event.timestamp,
                           created_at=created_at,
                           updated_at=created_at,
                           created_by=track_created_event.created_by,
                           updated_by=track_created_event.created_by))

        self.track_repository.save_Track(track)
        self.logger.info(
            f"Processed {TrackCreatedEvent.__name__}: id={track_created_event.id}, version={track_created_event.version}"
        )

    def handle_track_released_event(self,
                                    track_released_event: TrackReleasedEvent):
        updated_at = datetime.now(timezone.utc)
        track = self.track_repository.find_by_aggregate_id_and_is_active_true(
            track_released_event.id)
        if track is not None:
            if track.detail is None:
                track.detail = TrackDetail()
            # Update Track, TrackDetail
            release_detail = track_released_event.detail
            track.urn = track_released_event.urn
            track.detail.name = release_detail.name
            track.detail.description = release_detail.description
            track.detail.thumbnail_file_key = release_detail.thumbnail_file_key
            track.detail.thumbnail_url = release_detail.thumbnail_url
            track.is_released = track_released_event.is_released
            track.revision_number = track_released_event.revision_number
            track.ref_code = track_released_event.ref_code
            track.is_public = track_released_event.is_public
            track.is_active = track_released_event.is_active
            track.tags = [
                tag.name for tag in track_released_event.tags if tag.is_active
            ]
            track.tags_json = [
                tag.model_dump(by_alias=True)
                for tag in track_released_event.tags
            ]
            track.event_type = track_released_event.type
            track.event_version = track_released_event.version
            track.event_timestamp = track_released_event.timestamp
            track.updated_at = updated_at

            # Revision
            revision_attributes = {
                **track_released_event.model_dump(),
                "id": None,
                "track_id": track.id,
                "aggregate_id": track.aggregate_id,
                "name": track.detail.name,
                "tags_json": [
                    tag.model_dump(by_alias=True)
                    for tag in track_released_event.tags
                ],
                "tags": [
                    tag.name
                    for tag in track_released_event.tags
                    if tag.is_active
                ],
                "number": track_released_event.revision_number,
                "description": track.detail.description,
                "thumbnail_url": track.detail.thumbnail_url,
                "thumbnail_file_key": track.detail.thumbnail_file_key,
                "event_type": track.event_type,
                "event_version": track.event_version,
                "event_timestamp": track.event_timestamp,
                "created_at": track.created_at,
                "updated_at": track.updated_at,
                "created_by": track.created_by,
                "updated_by": track.updated_by,
            }
            revision = TrackRevision(**revision_attributes)
            track.revisions.append(revision)

            self.track_repository.save_Track(track)
        self.logger.info(
            f"Processed {TrackReleasedEvent.__name__}: id={track_released_event.id}, version={track_released_event.version}"
        )

    def handle_track_updated_event(self,
                                   track_updated_event: TrackUpdatedEvent):
        updated_at = datetime.now(timezone.utc)
        track = self.track_repository.find_by_aggregate_id_and_is_active_true(
            track_updated_event.id)
        if track is not None:
            if track.detail is None:
                track.detail = TrackDetail()
            track.detail.name = track_updated_event.detail.name
            track.tags = [
                tag.name for tag in track_updated_event.tags if tag.is_active
            ]
            track.tags_json = [
                tag.model_dump(by_alias=True)
                for tag in track_updated_event.tags
            ]
            track.is_released = track_updated_event.is_released
            track.is_public = track_updated_event.is_public
            track.detail.description = track_updated_event.detail.description
            track.detail.thumbnail_file_key = track_updated_event.detail.thumbnail_file_key
            track.detail.thumbnail_url = track_updated_event.detail.thumbnail_url
            track.event_type = track_updated_event.type
            track.event_timestamp = track_updated_event.timestamp
            track.event_version = track_updated_event.version
            track.updated_at = updated_at
            self.track_repository.save_Track(track)
        self.logger.info(
            f"Processed {TrackUpdatedEvent.__name__}: id={track_updated_event.id}, version={track_updated_event.version}, timestamp={track_updated_event.timestamp}"
        )

    def handle_track_deleted_event(self,
                                   track_deleted_event: TrackDeletedEvent):
        updated_at = datetime.now(timezone.utc)
        if track_deleted_event.is_soft_deleted:
            track = self.track_repository.find_by_aggregate_id_and_is_active_true(
                track_deleted_event.id)
            if track is not None:
                track.is_active = track_deleted_event.is_active
                track.event_type = track_deleted_event.type
                track.event_version = track_deleted_event.version
                track.event_timestamp = track_deleted_event.timestamp
                track.updated_at = updated_at
                self.track_repository.save_Track(track)
        else:
            self.track_repository.delete_by_aggregate_id(track_deleted_event.id)
        self.logger.info(
            f"Processed {TrackDeletedEvent.__name__}: id={track_deleted_event.id}, version={track_deleted_event.version}, timestamp={track_deleted_event.timestamp}"
        )
