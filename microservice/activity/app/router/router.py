from fastapi import APIRouter
from app.router.activity_router import activity_router

api_router = APIRouter()
routers = [activity_router]

for router in routers:
    api_router.include_router(router)
