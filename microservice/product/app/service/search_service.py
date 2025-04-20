from app.core.logger import Logger
from app.repository.artist_detail_repository import ArtistDetailRepository
from app.repository.artist_detail_repository import ArtistDetailRepository
from app.mapper.artist_mapper import map_to_artist_detail_schema
from app.core.logger import Logger
from app.schema.artist_schema import ArtistDetailSchema


class SearchService:

    def __init__(self, logger: Logger,
                 artist_detail_repository: ArtistDetailRepository):
        self.logger = logger
        self.artist_detail_repository = artist_detail_repository

    def search_artist(self,
                      keyword: str,
                      page: int = 0,
                      size: int = 50) -> list[ArtistDetailSchema]:
        artist_details = self.artist_detail_repository.find_by_keyword(
            keyword, page, size)
        return [
            map_to_artist_detail_schema(artist_detail)
            for artist_detail in artist_details
        ]
