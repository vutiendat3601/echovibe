from app.model.artist import Artist, ArtistImage
from app.schema.artist_schema import ArtistSchema, ArtistProfileSchema, ArtistImageSchema


def map_to_image_schema(artist_image: ArtistImage):
    return ArtistImageSchema(file_url=artist_image.file_url,
                             type=artist_image.type,
                             created_at=artist_image.created_at,
                             created_by=artist_image.created_by)


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
    images = None
    if (is_load_images):
        images = [map_to_image_schema(image) for image in images]
        print(f"{artist.images}")
    revisions = None
    if (is_load_revisions):
        revisions = []
        print(f"{artist.revisions}")
    # if (artist.)
    # revision_schemas: list[revision_schemas]
    return ArtistSchema(id=artist.aggregate_id,
                        urn=artist.urn,
                        ref_code=artist.ref_code,
                        is_public=artist.is_public,
                        is_verified=artist.is_verified,
                        is_released=artist.is_released,
                        revision_number=artist.revision_number,
                        tags=artist.tags,
                        profile=profile_schema,
                        created_at=artist.created_at,
                        updated_at=artist.updated_at,
                        created_by=artist.created_by,
                        updated_by=artist.updated_by)
