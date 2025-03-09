from app.model.artist import Artist
from app.schema.artist_schema import ArtistSchema


def map_to_artist_schema(artist: Artist):
    return ArtistSchema(id=artist.id,
                        urn=artist.urn,
                        name=artist.name,
                        biography=artist.biography,
                        description=artist.description,
                        is_public=artist.is_public,
                        thumbnail_url=artist.thumbnail_url,
                        background_url=artist.background_url,
                        tags=artist.tags)
