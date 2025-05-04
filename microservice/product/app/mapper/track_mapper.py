from app.model.track import TrackDetail
from app.schema.track_schema import TrackDetailSchema, TrackArtistSchema


def map_to_track_detail_schema(track_detail: TrackDetail):
    artists = []
    if track_detail.artists_json:
        for artist in track_detail.artists_json:
            artists.append(TrackArtistSchema(**artist))

    return TrackDetailSchema(
        id=track_detail.aggregate_id,
        urn=track_detail.urn,
        name=track_detail.name,
        description=track_detail.description,
        thumbnail_url=track_detail.thumbnail_url,
        official_released_date=track_detail.official_released_date,
        is_public=track_detail.is_public,
        tags=track_detail.tags,
        audio_file_m3u8_url=track_detail.audio_file_m3u8_url,
        audio_duration_second=track_detail.audio_duration_second,
        artists=artists)
