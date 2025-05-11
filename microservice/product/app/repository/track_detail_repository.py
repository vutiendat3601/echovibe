from abc import ABC, abstractmethod
from app.model.track import TrackDetail


class TrackDetailRepository(ABC):

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> TrackDetail:
        """Find TrackDetail by aggregate_id"""

    @abstractmethod
    def find_by_aggregate_ids(self,
                              aggregate_ids: list[str]) -> list[TrackDetail]:
        """Find TrackDetail by aggregate_ids"""

    @abstractmethod
    def find_by_artist_id(self, artist_id: str) -> list[TrackDetail]:
        """Find TrackDetail by artist_id"""

    @abstractmethod
    def find_by_keyword(self, keyword: str, page: int,
                        size: int) -> list[TrackDetail]:
        """Find TrackDetail by keyword"""
