from app.repository.user_repository import (UserDataRepository,
                                            UserUsageDataRepository,
                                            UserPlaylistRepository)
from app.model.user import UserData, UserUsageData, UserPlaylist
from sqlalchemy.exc import SQLAlchemyError
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from sqlmodel import Session
from sqlmodel import Session, select


class SqlmodelUserDataRepository(UserDataRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_user_data(self, user_data: UserData) -> UserData | None:
        try:
            with self.session_factory() as session:
                session.add(user_data)
                session.commit()
                session.refresh(user_data)
                session.expunge_all()
                return user_data
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelUserUsageDataRepository(UserUsageDataRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def find_by_user_id(self, user_id: str) -> UserUsageData | None:
        try:
            with self.session_factory() as session:
                statement = (select(UserUsageData).filter(
                    UserUsageData.user_id == user_id))
                user_stats = session.exec(statement).first()
                return user_stats
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelUserPlaylistRepository(UserPlaylistRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_user_playlist(self,
                           user_playlist: UserPlaylist) -> UserPlaylist | None:
        try:
            with self.session_factory() as session:
                session.add(user_playlist)
                session.commit()
                session.refresh(user_playlist)
                session.expunge_all()
                return user_playlist
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_playlist_id_and_is_active(
            self, playlist_id: str, is_active: bool) -> UserPlaylist | None:
        try:
            with self.session_factory() as session:
                statement = (select(UserPlaylist).filter(
                    UserPlaylist.playlist_id == playlist_id,
                    UserPlaylist.is_active == is_active))
                user_playlist = session.exec(statement).first()
                return user_playlist
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
