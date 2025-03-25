from abc import ABC, abstractmethod
from app.model.artist import Artist


class ArtistRepository(ABC):

    @abstractmethod
    def find_by_aggregate_id_and_is_active_true(
            self,
            aggregate_id: str,
            isLoadImages: bool = False,
            isLoadRevisions: bool = True) -> Artist | None:
        pass

    @abstractmethod
    def find_by_aggregate_ids_and_is_active_true(
            self,
            aggregate_ids: list[str],
            isLoadImages: bool = False,
            isLoadRevisions: bool = True) -> list[Artist]:
        pass

    @abstractmethod
    def find_by_ref_codes_and_is_active_true(
            self,
            ref_codes: list[str],
            isLoadImages: bool = False,
            isLoadRevisions: bool = True) -> list[Artist]:
        pass

    @abstractmethod
    def save_artist(self, artist: Artist) -> Artist:
        pass

    @abstractmethod
    def delete_artist(self, aggregate_id: str) -> None:
        pass
