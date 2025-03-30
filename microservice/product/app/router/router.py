from fastapi import APIRouter
from app.router.artist_router import artist_router
from app.router.search_router import search_router

apiRouter = APIRouter()
routers = [artist_router, search_router]

for router in routers:
    apiRouter.include_router(router)
