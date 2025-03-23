from sqlmodel import Session, select, delete
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import selectinload
from contextlib import AbstractContextManager
from app.model.artist import Artist
from app.repository.abstract.abstract_artist_repository import AbstractArtistRepository
from typing import Callable
from app.core.logger import Logger


class ArtistRepository(AbstractArtistRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def find_by_aggregate_id_and_is_active_true(self,
                                                aggregate_id: str) -> Artist:
        with self.session_factory() as session:
            statement = (select(Artist).options(selectinload(
                Artist.profile)).filter(Artist.is_active == True,
                                        Artist.aggregate_id == aggregate_id))
            artist = session.exec(statement).first()
            return artist

    def find_by_aggregate_ids_and_is_active_true(self,
                                                 aggregate_ids: list[str]):
        with self.session_factory() as session:
            statement = (select(Artist).options(selectinload(
                Artist.profile)).filter(Artist.is_active == True,
                                        Artist.aggregate_id.in_(aggregate_ids)))
            artists = session.exec(statement).all()
            return artists

    def find_by_ref_codes_and_is_active_true(self, ref_codes: list[str]):
        with self.session_factory() as session:
            statement = (select(Artist).options(selectinload(
                Artist.profile)).filter(Artist.is_active == True,
                                        Artist.ref_code.in_(ref_codes)))
            artists = session.exec(statement).all()
            return artists

    def save_artist(self, artist: Artist) -> Artist:
        try:
            with self.session_factory() as session:
                session.add(artist)
                session.commit()
                session.refresh(artist)
                session.expunge_all()
                return artist
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
        finally:
            session.close()

    def delete_artist(self, aggregate_id: str) -> None:
        try:
            with self.session_factory() as session:
                statement = (delete(Artist).where(
                    Artist.aggregate_id == aggregate_id))
                session.exec(statement)
                session.commit()
                session.expunge_all()
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
        finally:
            session.close()
