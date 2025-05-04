from app.core.logger import Logger
from app.repository.artist_detail_repository import ArtistDetailRepository
from app.repository.track_detail_repository import TrackDetailRepository
from app.repository.playlist_detail_repository import PlaylistDetailRepository
from app.mapper.artist_mapper import map_to_artist_detail_schema
from app.mapper.track_mapper import map_to_track_detail_schema
from app.mapper.playlist_mapper import map_to_playlist_detail_schema
from app.core.logger import Logger
from app.schema.artist_schema import ArtistDetailSchema
from app.enum.search_type import SearchType
from app.schema.search_schema import SearchSchema, SearchResult
from app.schema.artist_schema import ArtistDetailSchema
from app.schema.track_schema import TrackDetailSchema
from app.schema.playlist_schema import PlaylistDetailSchema


class SearchService:

    def __init__(self, logger: Logger,
                 artist_detail_repository: ArtistDetailRepository,
                 track_detail_repository: TrackDetailRepository,
                 playlist_detail_repository: PlaylistDetailRepository) -> None:
        self.logger = logger
        self.artist_detail_repository = artist_detail_repository
        self.track_detail_repository = track_detail_repository
        self.playlist_detail_repository = playlist_detail_repository

    def search(self,
               types: list[SearchType],
               keyword: str,
               page: int = 0,
               size: int = 50) -> SearchSchema:
        keyword = keyword.strip()
        search_artist_result: SearchResult[ArtistDetailSchema] = None
        artist_detail_schemas: list[ArtistDetailSchema] | None = None
        if SearchType.ARTIST in types:
            artist_detail_schemas = []
            if keyword != "":
                artist_detail_schemas = self._search_artist(keyword, page, size)
            search_artist_result = SearchResult(items=artist_detail_schemas)

        search_track_result: SearchResult[TrackDetailSchema] = None
        track_detail_schemas: list[TrackDetailSchema] | None = None
        if SearchType.TRACK in types:
            track_detail_schemas = []
            if keyword != "":
                track_detail_schemas = self._search_track(keyword, page, size)
            search_track_result = SearchResult(items=track_detail_schemas)

        search_playlist_result: SearchResult[PlaylistDetailSchema] = None
        playlist_detail_schemas: list[PlaylistDetailSchema] | None = None
        if SearchType.PLAYLIST in types:
            playlist_detail_schemas = []
            if keyword != "":
                playlist_detail_schemas = self._search_playlist(
                    keyword, page, size)
            search_playlist_result = SearchResult(items=playlist_detail_schemas)

        return SearchSchema(keyword=keyword,
                            artist=search_artist_result,
                            track=search_track_result,
                            playlist=search_playlist_result)

    def _search_artist(self,
                       keyword: str,
                       page: int = 0,
                       size: int = 50) -> list[ArtistDetailSchema]:
        artist_details = self.artist_detail_repository.find_by_keyword(
            keyword, page, size)
        return [
            map_to_artist_detail_schema(artist_detail)
            for artist_detail in artist_details
        ]

    def _search_track(self,
                      keyword: str,
                      page: int = 0,
                      size: int = 50) -> list[ArtistDetailSchema]:
        track_details = self.track_detail_repository.find_by_keyword(
            keyword, page, size)
        return [
            map_to_track_detail_schema(track_detail)
            for track_detail in track_details
        ]

    def _search_playlist(self,
                         keyword: str,
                         page: int = 0,
                         size: int = 50) -> list[ArtistDetailSchema]:
        playlist_details = self.playlist_detail_repository.find_by_keyword(
            keyword, page, size)
        return [
            map_to_playlist_detail_schema(playlist_detail)
            for playlist_detail in playlist_details
        ]
