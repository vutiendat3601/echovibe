from sqlmodel import Session, select, delete
from sqlalchemy.exc import SQLAlchemyError
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from app.model.activity import Activity
from app.repository.activity_repository import ActivityRepository


class SqlmodelActivityRepository(ActivityRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_activity(self, activity: Activity) -> Activity:
        try:
            with self.session_factory() as session:
                session.add(activity)
                session.commit()
                session.refresh(activity)
                session.expunge_all()
                return activity
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id(self, aggregate_id: str) -> Activity | None:
        try:
            with self.session_factory() as session:
                statement = (select(Activity).filter(
                    Activity.aggregate_id == aggregate_id))
                activity = session.exec(statement).first()
                return activity
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
