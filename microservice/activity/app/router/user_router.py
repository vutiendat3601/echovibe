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

user_router = APIRouter(prefix="/v1", tags=["User"])

logger: Logger = Provide[Container.logger]
user_service: UserService = Provide[Container.user_service]


@user_router.get(path="/me/usage_data",
                 response_model=ResponseSchema[UserUsageDataSchema])
async def get_user_usage_data(authorization: str | None = Header(
    None, alias="Authorization")):
    jwt = authorization.removeprefix("Bearer ") if authorization else None
    jwt_claims = {}
    if jwt:
        jwt_claims = verify_jwt_token(jwt)
    user_id = jwt_claims.get(
        JWT_CLAIM_SUB,
        AUTH_SYSTEM_USERNAME) if jwt_claims else AUTH_SYSTEM_USERNAME
    user_usage_data_schema = user_service.get_user_usage_data(user_id)
    response = ok(data=user_usage_data_schema)
    return JSONResponse(content=jsonable_encoder(response))
