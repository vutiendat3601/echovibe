from pydantic import BaseModel
import hashlib
import json


def generate_etag(text: str) -> str:
    return hashlib.md5(text.encode("utf-8")).hexdigest()
