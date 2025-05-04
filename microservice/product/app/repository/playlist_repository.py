from abc import ABC, abstractmethod
from app.model.playlist import Playlist


class PlaylistRepository(ABC):

    @abstractmethod
    def save_playlist(self, playlist: Playlist) -> Playlist:
        """Save Playlist"""

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> Playlist | None:
        """Find Playlist by aggregate_id"""

    @abstractmethod
    def find_by_aggregate_id_and_is_active_true(
            self, aggregate_id: str) -> Playlist | None:
        """Find Playlist by aggregate_id"""

    @abstractmethod
    def delete_by_aggregate_id(self, aggregate_id: str) -> None:
        """Find Playlist by aggregate_id"""
