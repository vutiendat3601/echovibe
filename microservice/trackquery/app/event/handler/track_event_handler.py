from app.core.logger import Logger
from datetime import datetime, timezone
from app.repository.impl.sqlmodel_track_repository import TrackRepository
from app.event.schema.track_event_schema import (TrackCreatedEvent,
                                                 TrackReleasedEvent,
                                                 TrackUpdatedEvent,
                                                 TrackDeletedEvent)
from app.model.track import (Track, TrackDetail, TrackArtist, TrackImage,
                             TrackRevision)
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
        track_artists = [
            TrackArtist(aggregate_id=track_created_event.id,
                        artist_aggregate_id=track_artist.artist_id,
                        event_type=track_created_event.type,
                        event_version=track_created_event.version,
                        event_timestamp=track_created_event.timestamp,
                        created_at=created_at,
                        updated_at=created_at,
                        created_by=track_created_event.created_by,
                        updated_by=track_created_event.created_by)
            for track_artist in track_created_event.track_artists
        ]
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
            "track_artists": track_artists,
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
                           ref_code=track_created_event.ref_code,
                           type=TrackImageType.THUMBNAIL,
                           aggregate_id=track_created_event.id,
                           event_type=track_created_event.type,
                           event_version=track_created_event.version,
                           event_timestamp=track_created_event.timestamp,
                           created_at=created_at,
                           updated_at=created_at,
                           created_by=track_created_event.created_by,
                           updated_by=track_created_event.created_by))

        self.track_repository.save_track(track)
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
            track.detail.official_released_date = release_detail.official_released_date
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

            self.track_repository.save_track(track)
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
            track_detail = track_updated_event.detail
            track.detail.name = track_detail.name
            track.is_released = track_updated_event.is_released
            track.is_public = track_updated_event.is_public
            track.detail.description = track_detail.description
            track.detail.thumbnail_file_key = track_detail.thumbnail_file_key
            track.detail.thumbnail_url = track_detail.thumbnail_url
            track.detail.official_released_date = track_detail.official_released_date
            track.event_type = track_updated_event.type
            track.event_timestamp = track_updated_event.timestamp
            track.event_version = track_updated_event.version
            track.updated_at = updated_at
            track.ref_code = track_updated_event.ref_code
            track.tags = [
                tag.name for tag in track_updated_event.tags if tag.is_active
            ]
            track.tags_json = [
                tag.model_dump(by_alias=True)
                for tag in track_updated_event.tags
            ]

            for track_artist in track_updated_event.track_artists:
                existed_track_artist: TrackArtist = next(
                    (item for item in track.track_artists
                     if item.artist_aggregate_id == track_artist.artist_id),
                    None)
                if existed_track_artist is None:
                    track.track_artists.append(
                        TrackArtist(
                            aggregate_id=track_updated_event.id,
                            artist_aggregate_id=track_artist.artist_id,
                            event_type=track_updated_event.type,
                            event_version=track_updated_event.version,
                            event_timestamp=track_updated_event.timestamp,
                            created_at=updated_at,
                            updated_at=updated_at,
                            created_by=track_updated_event.created_by,
                            updated_by=track_updated_event.created_by))
                else:
                    existed_track_artist.is_active = track_artist.is_active
                    existed_track_artist.is_main_artist = track_artist.is_main_artist
                    existed_track_artist.event_type = track_updated_event.type
                    existed_track_artist.event_version = track_updated_event.version
                    existed_track_artist.event_timestamp = track_updated_event.timestamp
                    existed_track_artist.updated_at = updated_at
                    existed_track_artist.updated_by = track_updated_event.created_by

            self.track_repository.save_track(track)
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
                self.track_repository.save_track(track)
        else:
            self.track_repository.delete_by_aggregate_id(track_deleted_event.id)
        self.logger.info(
            f"Processed {TrackDeletedEvent.__name__}: id={track_deleted_event.id}, version={track_deleted_event.version}, timestamp={track_deleted_event.timestamp}"
        )
