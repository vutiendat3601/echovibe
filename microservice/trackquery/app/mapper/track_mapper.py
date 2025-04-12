from app.model.track import (Track, TrackImage, TrackRevision)
from app.schema.track_schema import (TrackSchema, TrackDetailSchema,
                                     TrackImageSchema, TrackRevisionSchema)
from app.schema.tag_schema import TagSchema


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
        biography=track_revision.biography,
        nationality_iso_code=track_revision.nationality_iso_code,
        thumbnail_url=track_revision.thumbnail_url,
        background_url=track_revision.background_url,
        tags=[TagSchema(**tag) for tag in track_revision.tags_json],
        created_at=track_revision.created_at,
        created_by=track_revision.created_by)


def map_to_track_schema(track: Track,
                        is_load_images: bool = False,
                        is_load_revisions: bool = False):
    # TODO: map thumbnail_file_key to thumbnail_url in case thumbnail_url is null.
    # TODO: map background_file_key to background_url in case background_url is null.
    detail = track.detail
    profile_schema: TrackDetailSchema = TrackDetailSchema(
        name=detail.name,
        description=detail.description,
        thumbnail_url=detail.thumbnail_url)
    images: list[TrackImageSchema] | None = None
    if is_load_images:
        images = [map_to_image_schema(image) for image in track.images]
    revisions: list[TrackRevisionSchema] | None = None
    if is_load_revisions:
        revisions = [
            map_to_revision_schema(revision) for revision in track.revisions
        ]
    return TrackSchema(id=track.aggregate_id,
                       urn=track.urn,
                       ref_code=track.ref_code,
                       is_public=track.is_public,
                       is_released=track.is_released,
                       tags=[TagSchema(**tag) for tag in track.tags_json],
                       profile=profile_schema,
                       images=images,
                       revision_number=track.revision_number,
                       revisions=revisions,
                       created_at=track.created_at,
                       updated_at=track.updated_at,
                       created_by=track.created_by,
                       updated_by=track.updated_by)
