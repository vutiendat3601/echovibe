from sqlmodel import create_engine, Session
import os
from typing import Generator, Any
from contextlib import AbstractContextManager, contextmanager


class Database:

    def __init__(self, database_uri: str) -> None:
        self._engine = create_engine(database_uri,
                                     echo=False,
                                     pool_pre_ping=True)

    @contextmanager
    def session(self) -> Generator[Any, Any, AbstractContextManager[Session]]:
        session: Session = Session(bind=self._engine, expire_on_commit=False)
        try:
            yield session
        except Exception as e:
            session.rollback()
            raise e
        finally:
            session.close()
