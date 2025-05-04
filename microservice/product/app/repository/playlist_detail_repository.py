from abc import ABC, abstractmethod
from app.model.playlist import PlaylistDetail


class PlaylistDetailRepository(ABC):

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> PlaylistDetail:
        """Find Playlist by aggregate_id"""

    @abstractmethod
    def find_by_aggregate_ids(self,
                              aggregate_ids: list[str]) -> list[PlaylistDetail]:
        """Find Playlist by aggregate_ids"""

    @abstractmethod
    def find_by_keyword(self, keyword: str, page: int,
                        size: int) -> list[PlaylistDetail]:
        """Find Playlist by keyword"""
