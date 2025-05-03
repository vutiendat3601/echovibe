from sqlmodel import Session, select, delete
from sqlalchemy.exc import SQLAlchemyError
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from app.model.playlist import Playlist
from app.repository.playlist_repository import PlaylistRepository


class SqlmodelPlaylistRepository(PlaylistRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_playlist(self, playlist: Playlist) -> Playlist:
        try:
            with self.session_factory() as session:
                session.add(playlist)
                session.commit()
                session.refresh(playlist)
                session.expunge_all()
                return playlist
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id(self, aggregate_id: str) -> Playlist | None:
        try:
            with self.session_factory() as session:
                statement = (select(Playlist).filter(
                    Playlist.aggregate_id == aggregate_id))
                playlist = session.exec(statement).first()
                return playlist
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id_and_is_active_true(
            self, aggregate_id: str) -> Playlist | None:
        try:
            with self.session_factory() as session:
                statement = (select(Playlist).filter(
                    Playlist.is_active == True,
                    Playlist.aggregate_id == aggregate_id))
                playlist = session.exec(statement).first()
                return playlist
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def delete_by_aggregate_id(self, aggregate_id: str) -> None:
        try:
            with self.session_factory() as session:
                statement = (delete(Playlist).where(
                    Playlist.aggregate_id == aggregate_id))
                session.exec(statement)
                session.commit()
                session.expunge_all()
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
