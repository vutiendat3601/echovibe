from fastapi import HTTPException, status
from typing import Optional, Any


class NotFoundException(HTTPException):

    def __init__(self, message: str, headers: Optional[dict[str, Any]] = None):
        super().__init__(status.HTTP_404_NOT_FOUND,
                         detail=message,
                         headers=headers)
