from app.repository.user_repository import (UserDataRepository,
                                            UserUsageDataRepository)
from app.model.user import UserData, UserUsageData
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
