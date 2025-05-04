from typing import Generic, TypeVar
from pydantic import BaseModel, Field
from typing import Optional
from http import HTTPStatus

T = TypeVar("T")


class ResponseSchema(BaseModel, Generic[T]):
    status: str
    message: str
    data: Optional[T] = None


def ok(message: str = "Request processed successfully.",
       data: Optional[T] = None) -> ResponseSchema[Optional[T]]:
    return ResponseSchema(status=HTTPStatus.OK.phrase,
                          message=message,
                          data=data)
