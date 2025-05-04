from fastapi import APIRouter, Header
from app.core.container import Container
from dependency_injector.wiring import Provide
from app.core.logger import Logger
from app.util.jwt_extractor import verify_jwt_token
from app.service.user_service import UserService
from app.schema.schema import ResponseSchema, ok
from app.schema.user_schema import UserStatsSchema
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
from app.constant.constant import AUTH_SYSTEM_USERNAME

user_router = APIRouter(prefix="/v1", tags=["User"])

logger: Logger = Provide[Container.logger]
user_service: UserService = Provide[Container.user_service]


@user_router.get(path="/me/stats",
                 response_model=ResponseSchema[UserStatsSchema])
async def get_user_stats(authorization: str | None = Header(
    None, alias="Authorization")):
    jwt = authorization.removeprefix("Bearer ") if authorization else None
    jwt_claims = {}
    if jwt:
        jwt_claims = verify_jwt_token(jwt)
    user_id = jwt_claims.get(
        "user_id", AUTH_SYSTEM_USERNAME) if jwt_claims else AUTH_SYSTEM_USERNAME
    user_stats_schema = user_service.get_user_stats(user_id)
    response = ok(data=user_stats_schema)
    return JSONResponse(content=jsonable_encoder(response))
