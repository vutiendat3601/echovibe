from sqlmodel import Session, select
from contextlib import AbstractContextManager
from app.model.artist import ArtistDetail
from app.repository.artist_detail_repository import ArtistDetailRepository
from typing import Callable
from app.core.logger import Logger
from sqlalchemy.exc import SQLAlchemyError


class SqlmodelArtistDetailRepository(ArtistDetailRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.session_factory = session_factory
        self.logger = logger

    def find_by_aggregate_id(self, aggregate_id: str) -> ArtistDetail:
        try:
            with self.session_factory() as session:
                statement = (select(ArtistDetail).where(
                    ArtistDetail.aggregate_id == aggregate_id))
                artist_detail = session.exec(statement).first()
                session.expunge_all()
                return artist_detail
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_ids(self, aggregate_ids: list[str]):
        try:
            with self.session_factory() as session:
                statement = (select(ArtistDetail).where(
                    ArtistDetail.aggregate_id.in_(aggregate_ids)))
                artists = session.exec(statement).all()
                return artists
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
