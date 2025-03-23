from abc import ABC, abstractmethod
from app.model.artist import Artist


class AbstractArtistRepository(ABC):

    @abstractmethod
    def find_by_aggregate_id_and_is_active_true(self, aggregate_id: str) -> Artist:
        """Find Artist by aggregate_id"""
    @abstractmethod
    def find_by_aggregate_ids_and_is_active_true(self, aggregate_ids: list[str]):
        """Find Artist by aggregate_ids"""
