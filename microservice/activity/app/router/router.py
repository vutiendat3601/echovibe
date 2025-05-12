from fastapi import APIRouter
from app.router.activity_router import activity_router
from app.router.artist_router import artist_router
from app.router.track_router import track_router
from app.router.user_router import user_router

api_router = APIRouter()
routers = [activity_router, artist_router, track_router, user_router]

for router in routers:
    api_router.include_router(router)
