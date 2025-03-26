from app.model.artist import (Artist, ArtistImage, ArtistRevision)
from app.schema.artist_schema import (ArtistSchema, ArtistProfileSchema,
                                      ArtistImageSchema, ArtistRevisionSchema)


def map_to_image_schema(artist_image: ArtistImage):
    return ArtistImageSchema(url=artist_image.file_url,
                             type=artist_image.type,
                             created_at=artist_image.created_at,
                             created_by=artist_image.created_by)


def map_to_revision_schema(artist_revision: ArtistRevision):
    return ArtistRevisionSchema(
        number=artist_revision.number,
        ref_code=artist_revision.ref_code,
        name=artist_revision.name,
        urn=artist_revision.urn,
        is_public=artist_revision.is_public,
        is_released=artist_revision.is_released,
        is_verified=artist_revision.is_verified,
        is_active=artist_revision.is_active,
        description=artist_revision.description,
        biography=artist_revision.biography,
        nationality_iso_code=artist_revision.nationality_iso_code,
        thumbnail_url=artist_revision.thumbnail_url,
        background_url=artist_revision.background_url,
        tags=artist_revision.tags,
        created_at=artist_revision.created_at,
        created_by=artist_revision.created_by)


def map_to_artist_schema(artist: Artist,
                         is_load_images: bool = False,
                         is_load_revisions: bool = False):
    # TODO: map thumbnail_file_key to thumbnail_url in case thumbnail_url is null.
    # TODO: map background_file_key to background_url in case background_url is null.
    profile = artist.profile
    profile_schema: ArtistProfileSchema = ArtistProfileSchema(
        name=profile.name,
        biography=profile.biography,
        description=profile.description,
        nationality_iso_code=profile.nationality_iso_code,
        thumbnail_url=profile.thumbnail_url,
        background_url=profile.background_url)
    images: list[ArtistImageSchema] | None = None
    if is_load_images:
        images = [map_to_image_schema(image) for image in artist.images]
    revisions: list[ArtistRevisionSchema] | None = None
    if is_load_revisions:
        revisions = [
            map_to_revision_schema(revision) for revision in artist.revisions
        ]
    return ArtistSchema(id=artist.aggregate_id,
                        urn=artist.urn,
                        ref_code=artist.ref_code,
                        is_public=artist.is_public,
                        is_verified=artist.is_verified,
                        is_released=artist.is_released,
                        tags=artist.tags,
                        profile=profile_schema,
                        images=images,
                        revision_number=artist.revision_number,
                        revisions=revisions,
                        created_at=artist.created_at,
                        updated_at=artist.updated_at,
                        created_by=artist.created_by,
                        updated_by=artist.updated_by)
