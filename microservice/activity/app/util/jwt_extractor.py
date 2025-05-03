from fastapi import HTTPException
from jose import jwt
from jose.exceptions import JWTError
import requests
from app.core.configuration import configuration


def get_jwks():
    response = requests.get(configuration.get_open_id_connect_certs_url())
    response.raise_for_status()
    return response.json()["keys"]


jwks = get_jwks()


def verify_jwt_token(token: str):
    unverified_header = jwt.get_unverified_header(token)
    kid = unverified_header.get("kid")
    alg = unverified_header.get("alg")

    key = next((key for key in jwks if key["kid"] == kid), None)
    if key is None:
        raise HTTPException(status_code=401,
                            detail="Invalid token: key not found")

    try:
        return jwt.decode(token=token,
                          key=key,
                          algorithms=[alg],
                          options={"verify_aud": False})
    except JWTError as e:
        raise HTTPException(status_code=401,
                            detail=f"Token verification failed: {str(e)}")
