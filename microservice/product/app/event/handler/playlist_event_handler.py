from app.core.logger import Logger
from datetime import datetime, timezone
from app.repository.playlist_repository import (PlaylistRepository)
from app.event.schema.playlist_event_schema import (PlaylistCreatedEvent,
                                                    PlaylistUpdatedEvent,
                                                    PlaylistDeletedEvent)
from app.model.playlist import (Playlist)


class PlaylistEventHandler:

    def __init__(self, playlist_repository: PlaylistRepository, logger: Logger):
        self.playlist_repository = playlist_repository
        self.playlist_repository = playlist_repository
        self.logger = logger

    def handle_playlist_created_event(
            self, playlist_created_event: PlaylistCreatedEvent) -> None:
        created_at = datetime.now(timezone.utc)
        playlist = Playlist(
            aggregate_id=playlist_created_event.id,
            urn=playlist_created_event.urn,
            name=playlist_created_event.name,
            track_ids=playlist_created_event.track_ids,
            is_public=playlist_created_event.is_public,
            thumbnail_url=playlist_created_event.thumbnail_url,
            version=playlist_created_event.version,
            created_by=playlist_created_event.created_by,
            is_active=True,
            created_at=created_at,
            updated_at=created_at,
            event_type=playlist_created_event.type,
            event_version=playlist_created_event.version,
            event_timestamp=playlist_created_event.timestamp,
        )
        self.playlist_repository.save_playlist(playlist)
        self.logger.info(
            f"Processed {PlaylistCreatedEvent.__name__}: id={playlist.aggregate_id}, name={playlist.name}, created_by={playlist.created_by}, created_at={playlist.created_at}"
        )

    def handle_playlist_updated_event(
            self, playlist_updated_event: PlaylistUpdatedEvent) -> None:
        updated_at = datetime.now(timezone.utc)
        playlist = self.playlist_repository.find_by_aggregate_id_and_is_active_true(
            playlist_updated_event.id)
        if playlist:
            playlist.name = playlist_updated_event.name
            playlist.track_ids = playlist_updated_event.track_ids
            playlist.is_public = playlist_updated_event.is_public
            playlist.thumbnail_url = playlist_updated_event.thumbnail_url
            playlist.updated_at = updated_at
            playlist.event_type = playlist_updated_event.type
            playlist.event_version = playlist_updated_event.version
            playlist.event_timestamp = playlist_updated_event.timestamp
            playlist.updated_by = playlist_updated_event.created_by
            self.playlist_repository.save_playlist(playlist)
            self.logger.info(
                f"Processed {PlaylistUpdatedEvent.__name__}: id={playlist.aggregate_id}, name={playlist.name}, created_by={playlist.created_by}, created_at={playlist.created_at}"
            )

    def handle_playlist_deleted_event(
            self, playlist_deleted_event: PlaylistDeletedEvent) -> None:
        if playlist_deleted_event.is_soft_deleted:
            playlist = self.playlist_repository.find_by_aggregate_id_and_is_active_true(
                playlist_deleted_event.id)
            if playlist is not None:
                updated_at = datetime.now(timezone.utc)
                playlist.is_active = playlist_deleted_event.is_active
                playlist.event_type = playlist_deleted_event.type
                playlist.event_version = playlist_deleted_event.version
                playlist.event_timestamp = playlist_deleted_event.timestamp
                playlist.updated_at = updated_at
                self.playlist_repository.save_playlist(playlist)
        else:
            self.playlist_repository.delete_by_aggregate_id(
                playlist_deleted_event.id)
        self.logger.info(
            f"Processed {PlaylistDeletedEvent.__name__}: id={playlist_deleted_event.id}, version={playlist_deleted_event.version}, timestamp={playlist_deleted_event.timestamp}"
        )
