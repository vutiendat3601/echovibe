from fastapi import APIRouter
from app.router.artist_router import artist_router

apiRouter = APIRouter()
routers = [artist_router]

for router in routers:
    apiRouter.include_router(router)
