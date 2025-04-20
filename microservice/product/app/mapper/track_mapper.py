from app.model.track import TrackDetail
from app.schema.track_schema import TrackDetailSchema
from app.schema.artist_schema import ArtistDetailSchema


def map_to_track_detail_schema(track_detail: TrackDetail):
    track_artists = []
    if track_detail.artists_json:
        for artist in track_detail.artists_json:
            track_artists.append(ArtistDetailSchema(**artist))

    return TrackDetailSchema(
        id=track_detail.aggregate_id,
        urn=track_detail.urn,
        name=track_detail.name,
        description=track_detail.description,
        thumbnail_url=track_detail.thumbnail_url,
        official_released_date=track_detail.official_released_date,
        is_public=track_detail.is_public,
        tags=track_detail.tags,
        track_artists=track_artists)
