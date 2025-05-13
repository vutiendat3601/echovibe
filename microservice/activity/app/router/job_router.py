from fastapi import APIRouter, Header
from app.core.container import Container
from dependency_injector.wiring import Provide
from app.core.logger import Logger
from app.util.jwt_extractor import verify_jwt_token
from app.service.user_service import UserService
from app.schema.schema import ResponseSchema, ok
from app.schema.user_schema import UserUsageDataSchema
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
from app.constant.constant import AUTH_SYSTEM_USERNAME, JWT_CLAIM_SUB

job_router = APIRouter(prefix="/internal/v1", tags=["Job"])

logger: Logger = Provide[Container.logger]
user_service: UserService = Provide[Container.user_service]
import asyncio


@job_router.get(path="/job/user-track-recommendation",
                response_model=ResponseSchema[UserUsageDataSchema])
async def process_user_track_recommendation():
    asyncio.create_task(user_service.process_user_track_recommendation())
    response = ok()
    return JSONResponse(content=jsonable_encoder(response))
