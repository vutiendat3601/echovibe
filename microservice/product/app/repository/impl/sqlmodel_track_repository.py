from sqlmodel import Session, select, delete
from sqlalchemy.exc import SQLAlchemyError
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from app.model.track import Track
from app.repository.track_repository import TrackRepository


class SqlmodelTrackRepository(TrackRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_track(self, track: Track) -> Track:
        try:
            with self.session_factory() as session:
                session.add(track)
                session.commit()
                session.refresh(track)
                session.expunge_all()
                return track
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id_and_is_active_true(
            self, aggregate_id: str) -> Track | None:
        try:
            with self.session_factory() as session:
                statement = (select(Track).filter(
                    Track.is_active == True,
                    Track.aggregate_id == aggregate_id))
                track = session.exec(statement).first()
                return track
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def delete_by_aggregate_id(self, aggregate_id: str) -> None:
        try:
            with self.session_factory() as session:
                statement = (delete(Track).where(
                    Track.aggregate_id == aggregate_id))
                session.exec(statement)
                session.commit()
                session.expunge_all()
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
