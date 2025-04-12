from abc import ABC, abstractmethod
from app.model.track import Track


class TrackRepository(ABC):

    @abstractmethod
    def find_all_by_is_active_true(
            self,
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> list[Track]:
        """Find all active Tracks"""

    @abstractmethod
    def find_by_aggregate_id_and_is_active_true(
            self,
            aggregate_id: str,
            isLoadImages: bool = False,
            isLoadRevisions: bool = True) -> Track | None:
        """Find Track by ID"""

    @abstractmethod
    def find_by_aggregate_ids_and_is_active_true(
            self,
            aggregate_ids: list[str],
            isLoadImages: bool = False,
            isLoadRevisions: bool = True) -> list[Track]:
        """Find Track by IDs"""

    @abstractmethod
    def find_by_ref_codes_and_is_active_true(
            self,
            ref_codes: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> list[Track]:
        """Find Track by Reference Codes"""

    @abstractmethod
    def save_Track(self, Track: Track) -> Track:
        """Save Track"""

    @abstractmethod
    def delete_by_aggregate_id(self, aggregate_id: str) -> None:
        """Delete Track by aggregate_id"""
