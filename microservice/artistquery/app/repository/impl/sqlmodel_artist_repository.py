from sqlmodel import Session, select, delete
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import selectinload
from contextlib import AbstractContextManager
from app.model.artist import Artist
from typing import Callable
from app.core.logger import Logger
from app.repository.artist_repository import ArtistRepository


class SqlmodelArtistRepository(ArtistRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def find_all_by_is_active_true(
            self,
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> list[Artist]:
        options = self._build_options(is_load_images=is_load_images,
                                      is_load_revisions=is_load_revisions)
        try:
            with self.session_factory() as session:
                statement = (select(Artist).options(*options).filter(
                    Artist.is_active == True).order_by(
                        Artist.updated_at.desc()))
                artists = session.exec(statement).all()
                return artists
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id_and_is_active_true(
            self,
            aggregate_id: str,
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> Artist | None:
        options = self._build_options(is_load_images=is_load_images,
                                      is_load_revisions=is_load_revisions)
        try:
            with self.session_factory() as session:
                statement = (select(Artist).options(*options).filter(
                    Artist.is_active == True,
                    Artist.aggregate_id == aggregate_id))
                artist = session.exec(statement).first()
                return artist
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_ids_and_is_active_true(
            self,
            aggregate_ids: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> list[Artist]:
        try:
            with self.session_factory() as session:
                options = self._build_options(is_load_images, is_load_revisions)
                statement = (select(Artist).options(*options).filter(
                    Artist.is_active == True,
                    Artist.aggregate_id.in_(aggregate_ids)))
                artists = session.exec(statement).all()
                return artists
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_ref_codes_and_is_active_true(
            self,
            ref_codes: list[str],
            is_load_images: bool = False,
            is_load_revisions: bool = True) -> list[Artist]:
        options = self._build_options(is_load_images, is_load_revisions)
        try:
            with self.session_factory() as session:
                statement = (select(Artist).options(*options).filter(
                    Artist.is_active == True, Artist.ref_code.in_(ref_codes)))
                artists = session.exec(statement).all()
                return artists
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

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

    def delete_by_aggregate_id(self, aggregate_id: str) -> None:
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
            raise e
        finally:
            session.close()

    def _build_options(self,
                       is_load_images: bool = False,
                       is_load_revisions: bool = True):
        options = [selectinload(Artist.profile)]
        if (is_load_images):
            options.append(selectinload(Artist.images))
        if (is_load_revisions):
            options.append(selectinload(Artist.revisions))
        return options
