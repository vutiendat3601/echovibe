from sqlmodel import Session, select, delete
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import selectinload
from contextlib import AbstractContextManager
from app.model.track import Track
from typing import Callable
from app.core.logger import Logger
from app.repository.track_repository import TrackRepository


class SqlmodelTrackRepository(TrackRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def find_all_by_is_active_true(
            self,
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> list[Track]:
        options = self._build_options(is_load_images=is_load_images,
                                      is_load_revisions=is_load_revisions)
        try:
            with self.session_factory() as session:
                statement = (select(Track).options(*options).filter(
                    Track.is_active == True).order_by(Track.updated_at.desc()))
                tracks = session.exec(statement).all()
                return tracks
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id_and_is_active_true(
            self,
            aggregate_id: str,
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> Track | None:
        options = self._build_options(is_load_images=is_load_images,
                                      is_load_revisions=is_load_revisions)
        try:
            with self.session_factory() as session:
                statement = (select(Track).options(*options).filter(
                    Track.is_active == True,
                    Track.aggregate_id == aggregate_id))
                track = session.exec(statement).first()
                return track
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_ids_and_is_active_true(
            self,
            aggregate_ids: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> list[Track]:
        try:
            with self.session_factory() as session:
                options = self._build_options(is_load_images, is_load_revisions)
                statement = (select(Track).options(*options).filter(
                    Track.is_active == True,
                    Track.aggregate_id.in_(aggregate_ids)))
                tracks = session.exec(statement).all()
                return tracks
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_ref_codes_and_is_active_true(
            self,
            ref_codes: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> list[Track]:
        options = self._build_options(is_load_images, is_load_revisions)
        try:
            with self.session_factory() as session:
                statement = (select(Track).options(*options).filter(
                    Track.is_active == True, Track.ref_code.in_(ref_codes)))
                tracks = session.exec(statement).all()
                return tracks
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

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

    def _build_options(self,
                       is_load_images: bool = False,
                       is_load_revisions: bool = True):
        options = [
            selectinload(Track.detail),
            selectinload(Track.track_artists),
            selectinload(Track.track_audio),
        ]
        if (is_load_images):
            options.append(selectinload(Track.images))
        if (is_load_revisions):
            options.append(selectinload(Track.revisions))
        return options
