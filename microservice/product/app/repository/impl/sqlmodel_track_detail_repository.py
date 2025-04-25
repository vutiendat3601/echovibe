from sqlmodel import Session, select, text
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from sqlalchemy.exc import SQLAlchemyError
from app.model.track import TrackDetail
from app.repository.track_detail_repository import TrackDetailRepository


class SqlmodelTrackDetailRepository(TrackDetailRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.session_factory = session_factory
        self.logger = logger

    def find_by_aggregate_id(self, aggregate_id: str) -> TrackDetail:
        try:
            with self.session_factory() as session:
                statement = (select(TrackDetail).where(
                    TrackDetail.aggregate_id == aggregate_id))
                track_detail = session.exec(statement).first()
                session.expunge_all()
                return track_detail
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_ids(self, aggregate_ids: list[str]):
        try:
            with self.session_factory() as session:
                statement = (select(TrackDetail).where(
                    TrackDetail.aggregate_id.in_(aggregate_ids)))
                return session.exec(statement).all()
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_keyword(self, keyword: str, page: int,
                        size: int) -> list[TrackDetail]:
        try:
            with self.session_factory() as session:
                statement = text(
                    "SELECT id, aggregate_id, urn, name, description, is_public, thumbnail_file_key, thumbnail_url, audio_file_m3u8_url, official_released_date, tags, artists_json FROM search_track(:keyword) LIMIT :limit OFFSET :offset;"
                )
                search_track_records = session.exec(statement=statement,
                                                    params={
                                                        "keyword": keyword,
                                                        "limit": size,
                                                        "offset": page * size
                                                    }).all()
                return [
                    TrackDetail(id=search_track_record[0],
                                aggregate_id=search_track_record[1],
                                urn=search_track_record[2],
                                name=search_track_record[3],
                                description=search_track_record[4],
                                is_public=search_track_record[5],
                                thumbnail_file_key=search_track_record[6],
                                thumbnail_url=search_track_record[7],
                                audio_file_m3u8_url=search_track_record[8],
                                official_released_date=search_track_record[9],
                                tags=search_track_record[10],
                                artists_json=search_track_record[11])
                    for search_track_record in search_track_records
                ]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
