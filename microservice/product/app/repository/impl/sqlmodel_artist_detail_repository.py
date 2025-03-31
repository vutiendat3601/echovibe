from sqlmodel import Session, select, text
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from sqlalchemy.exc import SQLAlchemyError
from app.model.artist import ArtistDetail
from app.repository.artist_detail_repository import ArtistDetailRepository


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
                return session.exec(statement).all()
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_keyword(self, keyword: str, page: int,
                        size: int) -> list[ArtistDetail]:

        try:
            with self.session_factory() as session:
                statement = text(
                    "SELECT id, aggregate_id, urn, name, description, biography, nationality_iso_code, thumbnail_file_key, thumbnail_url, background_file_key, background_url, is_public, is_verified, tags FROM search_artist(:keyword) LIMIT :limit OFFSET :offset;"
                )
                search_artist_records = session.exec(statement=statement,
                                                     params={
                                                         "keyword": keyword,
                                                         "limit": size,
                                                         "offset": page * size
                                                     }).all()
                return [
                    ArtistDetail(id=search_artist_record[0],
                                 aggregate_id=search_artist_record[1],
                                 urn=search_artist_record[2],
                                 name=search_artist_record[3],
                                 description=search_artist_record[4],
                                 biography=search_artist_record[5],
                                 nationality_iso_code=search_artist_record[6],
                                 thumbnail_file_key=search_artist_record[7],
                                 thumbnail_url=search_artist_record[8],
                                 background_file_key=search_artist_record[9],
                                 background_url=search_artist_record[10],
                                 is_public=search_artist_record[11],
                                 is_verified=search_artist_record[12],
                                 tags=search_artist_record[13])
                    for search_artist_record in search_artist_records
                ]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
