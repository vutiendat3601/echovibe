from fastapi import APIRouter, Query
from dependency_injector.wiring import Provide
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from app.schema.artist_schema import (ArtistDetailSchema)
from app.service.artist_service import ArtistService
from app.core.container import Container
from app.schema.schema import ResponseSchema, ok
from app.enum.search_type import SearchType
from app.schema.search_schema import SearchSchema, SearchResult
from app.service.search_service import SearchService

search_router = APIRouter(prefix="/v1/search", tags=["Search"])

search_service: SearchService = Provide[Container.search_service]


@search_router.get("", response_model=ResponseSchema[SearchSchema])
def search(keyword: str,
           types: list[SearchType] = Query(),
           page: int = Query(default=0),
           size: int = Query(default=50)):
    artist_detail_schemas = None
    if SearchType.ARTIST in types:
        artist_detail_schemas = search_service.search_artist(
            keyword, page, size)
    search_artist_result = SearchResult(items=artist_detail_schemas)
    search_schema: SearchSchema = SearchSchema(keyword=keyword,
                                               artist=search_artist_result)
    response_scheme = ok(data=search_schema)
    return JSONResponse(content=jsonable_encoder(response_scheme))
