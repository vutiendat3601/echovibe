from sqlmodel import Session, select, delete
from contextlib import AbstractContextManager
from app.model.artist import Artist
from app.repository.abstract.abstract_artist_repository import AbstractArtistRepository
from typing import Callable


class ArtistRepository(AbstractArtistRepository):

    def __init__(
        self,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.session_factory = session_factory

    def find_by_aggregate_id(self, aggregate_id: str) -> Artist:
        with self.session_factory() as session:
            statement = (select(Artist).where(
                Artist.aggregate_id == aggregate_id))
            artist = session.exec(statement).one()
            session.expunge_all()
            return artist

    def find_by_aggregate_ids(self, aggregate_ids: list[str]):
        with self.session_factory() as session:
            statement = (select(Artist).where(
                Artist.aggregate_id.in_(aggregate_ids)))
            artists = session.exec(statement).all()
            session.expunge_all()
            return artists

    def save_artist(self, artist: Artist) -> Artist:
        with self.session_factory() as session:
            session.add(artist)
            session.commit()
            session.refresh(artist)
            session.expunge_all()
            return artist

    def delete_artist(self, aggregate_id: str) -> None:
        with self.session_factory() as session:
            statement = (delete(Artist).where(
                Artist.aggregate_id == aggregate_id))
            session.exec(statement)
            session.commit()
            session.expunge_all()
