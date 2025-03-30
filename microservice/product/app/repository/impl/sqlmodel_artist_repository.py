from sqlmodel import Session, select
from sqlalchemy.exc import SQLAlchemyError
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from app.model.artist import Artist
from app.repository.artist_repository import ArtistRepository


class SqlmodelArtistRepository(ArtistRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

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
            raise e
        finally:
            session.close()

    def find_by_aggregate_id_and_is_active_true(
            self, aggregate_id: str) -> Artist | None:
        try:
            with self.session_factory() as session:
                statement = (select(Artist).filter(
                    Artist.is_active == True,
                    Artist.aggregate_id == aggregate_id))
                artist = session.exec(statement).first()
                return artist
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
