from fastapi import APIRouter
from app.router.track_router import track_router

apiRouter = APIRouter()
routers = [track_router]

for router in routers:
    apiRouter.include_router(router)
