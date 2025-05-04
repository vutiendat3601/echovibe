from abc import ABC, abstractmethod
from app.model.artist import Artist


class ArtistRepository(ABC):

    @abstractmethod
    def save_artist(self, artist: Artist) -> Artist:
        """Save Artist"""

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> Artist | None:
        """Find Artist by aggregate_id"""

    @abstractmethod
    def find_by_aggregate_id_and_is_active_true(
            self, aggregate_id: str) -> Artist | None:
        """Find Artist by aggregate_id"""

    @abstractmethod
    def delete_by_aggregate_id(self, aggregate_id: str) -> None:
        """Find Artist by aggregate_id"""
