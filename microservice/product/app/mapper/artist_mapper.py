from app.model.artist import ArtistDetail
from app.schema.artist_schema import ArtistDetailSchema


def map_to_artist_detail_schema(artist_detail: ArtistDetail):
    return ArtistDetailSchema(
        id=artist_detail.aggregate_id,
        urn=artist_detail.urn,
        name=artist_detail.name,
        description=artist_detail.description,
        biography=artist_detail.biography,
        nationality_iso_code=artist_detail.nationality_iso_code,
        thumbnail_url=artist_detail.thumbnail_url,
        background_url=artist_detail.background_url,
        is_public=artist_detail.is_public,
        is_verified=artist_detail.is_verified,
        tags=artist_detail.tags)
