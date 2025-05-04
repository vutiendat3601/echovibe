from fastapi import APIRouter, Query
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.artist_schema import ArtistDetailSchema
from app.schema.track_schema import TrackDetailSchema
from app.schema.playlist_schema import PlaylistDetailSchema
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.enum.search_type import SearchType
from app.schema.search_schema import SearchSchema, SearchResult
from app.service.search_service import SearchService

search_router = APIRouter(prefix="/v1/search", tags=["Search"])

search_service: SearchService = Provide[Container.search_service]


@search_router.get("", response_model=ResponseSchema[SearchSchema])
def search(keyword: str = Query(...),
           types: str = Query(),
           page: int = Query(default=0),
           size: int = Query(default=50)):
    search_types: list[SearchType] = list(
        map(
            lambda st: SearchType[st],
            filter(lambda search_type: search_type in SearchType.__members__,
                   types.split(","))))
    search_schema: SearchSchema = search_service.search(types=search_types,
                                                        keyword=keyword,
                                                        page=page,
                                                        size=size)
    response_scheme = ok(data=search_schema)
    return JSONResponse(content=jsonable_encoder(response_scheme))
