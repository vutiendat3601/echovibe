from app.model.playlist import PlaylistDetail
from app.schema.playlist_schema import PlaylistDetailSchema
from app.schema.track_schema import TrackDetailSchema, TrackArtistSchema


def map_to_playlist_detail_schema(playlist_deatil: PlaylistDetail):
    tracks = []
    if playlist_deatil.tracks_json:
        for track in playlist_deatil.tracks_json:
            artists = []
            if track.get("artists_json"):
                for artist in track["artists_json"]:
                    artists.append(TrackArtistSchema(**artist))
            track["artists"] = artists
            tracks.append(TrackDetailSchema(**track))

    return PlaylistDetailSchema(id=playlist_deatil.aggregate_id,
                                urn=playlist_deatil.urn,
                                name=playlist_deatil.name,
                                thumbnail_url=playlist_deatil.thumbnail_url,
                                is_public=playlist_deatil.is_public,
                                tracks=tracks)
