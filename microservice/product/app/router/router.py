from fastapi import APIRouter
from app.router.artist_router import artist_router
from app.router.track_router import track_router
from app.router.search_router import search_router

api_router = APIRouter()
routers = [artist_router, track_router, search_router]

for router in routers:
    api_router.include_router(router)
