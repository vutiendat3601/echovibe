from app.model.track import (Track, TrackImage, TrackArtist, TrackRevision)
from app.schema.track_schema import (TrackSchema, TrackDetailSchema,
                                     TrackArtistSchema, TrackImageSchema,
                                     TrackRevisionSchema, TrackAudioSchema)
from app.schema.tag_schema import TagSchema


def map_to_track_artist_schema(track_artist: TrackArtist):
    return TrackArtistSchema(artist_id=track_artist.artist_aggregate_id,
                             is_active=track_artist.is_active,
                             is_main_artist=track_artist.is_main_artist)


def map_to_image_schema(track_image: TrackImage):
    return TrackImageSchema(url=track_image.file_url,
                            type=track_image.type,
                            created_at=track_image.created_at,
                            created_by=track_image.created_by)


def map_to_revision_schema(track_revision: TrackRevision):
    return TrackRevisionSchema(
        number=track_revision.number,
        ref_code=track_revision.ref_code,
        name=track_revision.name,
        urn=track_revision.urn,
        is_public=track_revision.is_public,
        is_released=track_revision.is_released,
        is_active=track_revision.is_active,
        description=track_revision.description,
        thumbnail_url=track_revision.thumbnail_url,
        tags=[TagSchema(**tag) for tag in track_revision.tags_json],
        created_at=track_revision.created_at,
        created_by=track_revision.created_by)


def map_to_track_schema(track: Track,
                        is_load_images: bool = False,
                        is_load_revisions: bool = False):
    # TODO: map thumbnail_file_key to thumbnail_url in case thumbnail_url is null.
    detail = track.detail
    detail_schema: TrackDetailSchema = TrackDetailSchema(
        name=detail.name,
        description=detail.description,
        thumbnail_url=detail.thumbnail_url,
        official_released_date=detail.official_released_date)
    track_artists: list[TrackArtistSchema] = [
        map_to_track_artist_schema(track_artist)
        for track_artist in track.track_artists
    ]
    images: list[TrackImageSchema] | None = None
    if is_load_images:
        images = [map_to_image_schema(image) for image in track.images]
    revisions: list[TrackRevisionSchema] | None = None
    if is_load_revisions:
        revisions = [
            map_to_revision_schema(revision) for revision in track.revisions
        ]
    audio: TrackAudioSchema | None = None
    if track.track_audio is not None:
        audio = TrackAudioSchema(
            file_m3u8_url=track.track_audio.file_m3u8_url,
            file_key=track.track_audio.file_key,
            is_active=track.track_audio.is_active,
            duration_second=track.track_audio.duration_second)

    return TrackSchema(id=track.aggregate_id,
                       urn=track.urn,
                       ref_code=track.ref_code,
                       is_public=track.is_public,
                       is_released=track.is_released,
                       tags=[TagSchema(**tag) for tag in track.tags_json],
                       detail=detail_schema,
                       track_artists=track_artists,
                       images=images,
                       revision_number=track.revision_number,
                       revisions=revisions,
                       audio=audio,
                       created_at=track.created_at,
                       updated_at=track.updated_at,
                       created_by=track.created_by,
                       updated_by=track.updated_by)
