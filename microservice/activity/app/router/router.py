from fastapi import APIRouter
from app.router.activity_router import activity_router
from app.router.user_router import user_router

api_router = APIRouter()
routers = [activity_router, user_router]

for router in routers:
    api_router.include_router(router)
