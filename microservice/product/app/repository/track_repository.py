from abc import ABC, abstractmethod
from app.model.track import Track


class TrackRepository(ABC):

    @abstractmethod
    def save_track(self, track: Track) -> Track:
        """Save Track"""

    @abstractmethod
    def find_by_aggregate_id_and_is_active_true(
            self, aggregate_id: str) -> Track | None:
        """Find Track by aggregate_id"""

    @abstractmethod
    def delete_by_aggregate_id(self, aggregate_id: str) -> None:
        """Find Track by aggregate_id"""
