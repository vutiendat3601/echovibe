from app.model.artist import Artist
from app.schema.artist_schema import ArtistSchema, ArtistProfileSchema


def map_to_artist_schema(artist: Artist):
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
    return ArtistSchema(id=artist.aggregate_id,
                        urn=artist.urn,
                        ref_code=artist.ref_code,
                        is_public=artist.is_public,
                        tags=artist.tags,
                        profile=profile_schema)
