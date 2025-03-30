from abc import ABC, abstractmethod
from app.model.artist import ArtistDetail


class ArtistDetailRepository(ABC):

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> ArtistDetail:
        """Find Artist by aggregate_id"""

    @abstractmethod
    def find_by_aggregate_ids(self,
                              aggregate_ids: list[str]) -> list[ArtistDetail]:
        """Find Artist by aggregate_ids"""

    @abstractmethod
    def find_by_keyword(self, keyword: str, page: int,
                        size: int) -> list[ArtistDetail]:
        """Find Artist by keyword"""
