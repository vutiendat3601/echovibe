from app.model.artist import Artist, ArtistProfile
from app.schema.artist_schema import ArtistSchema, ArtistProfileSchema


def map_to_artist_schema(artist: Artist):
    profile: ArtistProfileSchema = ArtistProfileSchema(**artist.profile.model_dump())
    return ArtistSchema(id=artist.aggregate_id,
                        urn=artist.urn,
                        profile=profile,
                        is_public=artist.is_public,
                        tags=artist.tags)
