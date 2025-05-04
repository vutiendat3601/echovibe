from sqlmodel import Session, select, text
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from sqlalchemy.exc import SQLAlchemyError
from app.model.playlist import PlaylistDetail
from app.repository.playlist_detail_repository import PlaylistDetailRepository


class SqlmodelPlaylistDetailRepository(PlaylistDetailRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.session_factory = session_factory
        self.logger = logger

    def find_by_aggregate_id(self, aggregate_id: str) -> PlaylistDetail:
        try:
            with self.session_factory() as session:
                statement = (select(PlaylistDetail).where(
                    PlaylistDetail.aggregate_id == aggregate_id))
                playlist_detail = session.exec(statement).first()
                session.expunge_all()
                return playlist_detail
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_ids(self, aggregate_ids: list[str]):
        try:
            with self.session_factory() as session:
                statement = (select(PlaylistDetail).where(
                    PlaylistDetail.aggregate_id.in_(aggregate_ids)))
                return session.exec(statement).all()
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_keyword(self, keyword: str, page: int,
                        size: int) -> list[PlaylistDetail]:
        try:
            with self.session_factory() as session:
                statement = text(
                    "SELECT id, aggregate_id, urn, name, is_public, thumbnail_url, tracks_json FROM search_playlist(:keyword) LIMIT :limit OFFSET :offset;"
                )
                search_playlist_records = session.exec(statement=statement,
                                                       params={
                                                           "keyword": keyword,
                                                           "limit": size,
                                                           "offset": page * size
                                                       }).all()
                return [
                    PlaylistDetail(id=search_playlist_record[0],
                                   aggregate_id=search_playlist_record[1],
                                   urn=search_playlist_record[2],
                                   name=search_playlist_record[3],
                                   is_public=search_playlist_record[4],
                                   thumbnail_url=search_playlist_record[5],
                                   tracks_json=search_playlist_record[6])
                    for search_playlist_record in search_playlist_records
                ]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
