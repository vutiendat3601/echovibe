from app.model.playlist import PlaylistDetail
from app.schema.playlist_schema import PlaylistDetailSchema
from app.schema.track_schema import TrackDetailSchema, TrackArtistSchema


def map_to_playlist_detail_schema(playlist_detail: PlaylistDetail):
    tracks = []
    if playlist_detail.tracks_json:
        for track in playlist_detail.tracks_json:
            artists = []
            if track.get("artists_json"):
                for artist in track["artists_json"]:
                    artists.append(TrackArtistSchema(**artist))
            track["artists"] = artists
            tracks.append(TrackDetailSchema(**track))

    return PlaylistDetailSchema(id=playlist_detail.aggregate_id,
                                urn=playlist_detail.urn,
                                name=playlist_detail.name,
                                thumbnail_url=playlist_detail.thumbnail_url,
                                is_public=playlist_detail.is_public,
                                tracks=tracks)
