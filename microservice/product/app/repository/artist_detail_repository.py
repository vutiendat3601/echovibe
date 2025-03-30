from abc import ABC, abstractmethod
from app.model.artist import Artist


class ArtistDetailRepository(ABC):

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> Artist:
        """Find Artist by aggregate_id"""

    @abstractmethod
    def find_by_aggregate_ids(self, aggregate_ids: list[str]):
        """Find Artist by aggregate_ids"""
