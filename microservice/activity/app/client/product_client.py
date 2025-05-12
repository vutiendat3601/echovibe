from typing import Generic, TypeVar, Optional
from typing import Optional
from app.schema.schema import ResponseSchema
from app.schema.track_schema import TrackDetailSchema
import requests

T = TypeVar("T")


class ProductClient:

    def __init__(self, base_url: str | None = None):
        if not base_url:
            raise ValueError("Base URL cannot be None")
        self._base_url = base_url

    async def get_all_tracks_by_artist_id(
            self,
            aritst_id: str,
            jwt: str | None = None) -> list[TrackDetailSchema]:
        session = requests.Session()
        if jwt:
            session.headers.update({"Authorization": f"Bearer {jwt}"})
        response = session.get(
            f"{self._base_url}/v1/tracks/byArtistId/{aritst_id}")
        response.raise_for_status()
        response.json()
        response_schema: ResponseSchema[dict[str, any]] = ResponseSchema(
            **response.json())
        return [
            TrackDetailSchema(**track_detail)
            for track_detail in response_schema.data
        ]
