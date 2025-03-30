from abc import ABC, abstractmethod
from app.model.artist import Artist


class ArtistRepository(ABC):

    @abstractmethod
    def find_by_aggregate_id_and_is_active_true(
            self,
            aggregate_id: str,
            isLoadImages: bool = False,
            isLoadRevisions: bool = True) -> Artist | None:
        """Find Artist by ID"""

    @abstractmethod
    def find_by_aggregate_ids_and_is_active_true(
            self,
            aggregate_ids: list[str],
            isLoadImages: bool = False,
            isLoadRevisions: bool = True) -> list[Artist]:
        """Find Artist by IDs"""

    @abstractmethod
    def find_by_ref_codes_and_is_active_true(
            self,
            ref_codes: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> list[Artist]:
        """Find Artist by Reference Codes"""

    @abstractmethod
    def save_artist(self, artist: Artist) -> Artist:
        """Save Artist"""

    @abstractmethod
    def delete_artist(self, aggregate_id: str) -> None:
        """Delete Artist"""
