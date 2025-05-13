from app.repository.artist_repository import (ArtistLikeRepository,
                                              ArtistDetailPageViewRepository,
                                              ArtistStatsRepository,
                                              ArtistRecommendationRepository,
                                              ArtistStatsDetailRepository,
                                              ArtistReportRepository)
from app.model.artist import (ArtistLike, ArtistDetailPageView, ArtistStats,
                              ArtistStatsDetail, ArtistRecommendation,
                              ArtistStatsReport)
from sqlalchemy.exc import SQLAlchemyError
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from sqlmodel import Session, select, text


class SqlmodelArtistLikeRepository(ArtistLikeRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_artist_like(self, artist_like: ArtistLike) -> None:
        try:
            with self.session_factory() as session:
                session.add(artist_like)
                session.commit()
                session.refresh(artist_like)
                session.expunge_all()
                return artist_like
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id_and_user_id(self, aggregate_id: str,
                                         user_id: str) -> ArtistLike | None:
        try:
            with self.session_factory() as session:
                statement = (select(ArtistLike).filter(
                    ArtistLike.aggregate_id == aggregate_id,
                    ArtistLike.user_id == user_id))
                artist_like = session.exec(statement).first()
                return artist_like
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelArtistDetailPageViewRepository(ArtistDetailPageViewRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_artist_detail_page_view(
            self, artist_detail_page_view: ArtistDetailPageView) -> None:
        try:
            with self.session_factory() as session:
                session.add(artist_detail_page_view)
                session.commit()
                session.refresh(artist_detail_page_view)
                session.expunge_all()
                return artist_detail_page_view
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def exist_by_session_id(self, session_id: str) -> bool:
        try:
            with self.session_factory() as session:
                statement = (select(ArtistDetailPageView).filter(
                    ArtistDetailPageView.session_id == session_id))
                track_detail_page_view = session.exec(statement).first()
                return True if track_detail_page_view else False
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_session_id(self,
                           session_id: str) -> ArtistDetailPageView | None:
        try:
            with self.session_factory() as session:
                statement = (select(ArtistDetailPageView).filter(
                    ArtistDetailPageView.session_id == session_id))
                artist_detail_page_view = session.exec(statement).first()
                return artist_detail_page_view
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelArtistStatsRepository(ArtistStatsRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_artist_stats(self, artist_stats: ArtistStats) -> None:
        try:
            with self.session_factory() as session:
                session.add(artist_stats)
                session.commit()
                session.refresh(artist_stats)
                session.expunge_all()
                return artist_stats
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id(self, aggregate_id: str) -> ArtistStats | None:
        try:
            with self.session_factory() as session:
                statement = (select(ArtistStats).filter(
                    ArtistStats.aggregate_id == aggregate_id))
                artist_stats = session.exec(statement).first()
                return artist_stats
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelArtistRecommendationRepository(ArtistRecommendationRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_artist_recommendation(
            self, artist_recommendation: ArtistRecommendation) -> None:
        try:
            with self.session_factory() as session:
                session.add(artist_recommendation)
                session.commit()
                session.refresh(artist_recommendation)
                session.expunge_all()
                return artist_recommendation
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id(self,
                             aggregate_id: str) -> ArtistRecommendation | None:
        try:
            with self.session_factory() as session:
                statement = (select(ArtistRecommendation).filter(
                    ArtistRecommendation.aggregate_id == aggregate_id))
                artist_recommendation = session.exec(statement).first()
                return artist_recommendation
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelArtistStatsDetailRepository(ArtistStatsDetailRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def find_by_aggregate_id(self,
                             aggregate_id: str) -> ArtistStatsDetail | None:
        try:
            with self.session_factory() as session:
                statement = (select(ArtistStatsDetail).filter(
                    ArtistStatsDetail.aggregate_id == aggregate_id))
                artist_stats_detail = session.exec(statement).first()
                return artist_stats_detail
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelArtistReportRepository(ArtistReportRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def find_artist_stats_report_by_aggregate_ids(
            self, aggregate_ids: list[str]) -> list[ArtistStatsReport]:
        try:
            with self.session_factory() as session:
                statement = text(
                    'SELECT aggregate_id, "year", "month", total_artist_detail_page_view_duration_seconds, total_artist_detail_page_views, score FROM v_artist_stats_report WHERE aggregate_id IN :aggregate_ids ORDER BY score DESC;'
                )
                artist_stats_report_records = session.exec(statement=statement,
                                                           params={
                                                               "aggregate_ids":
                                                                   aggregate_ids
                                                           }).all()
                return [
                    ArtistStatsReport(
                        aggregate_id=artist_stats_report_record[0],
                        year=artist_stats_report_record[1],
                        month=artist_stats_report_record[2],
                        total_artist_detail_page_view_duration_seconds=
                        artist_stats_report_record[3],
                        total_artist_detail_page_views=
                        artist_stats_report_record[4],
                        score=artist_stats_report_record[5]) for
                    artist_stats_report_record in artist_stats_report_records
                ]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_artist_current_month_stats_report_by_aggregate_ids(
            self, aggregate_ids: list[str]) -> list[ArtistStatsReport]:
        try:
            with self.session_factory() as session:
                statement = text(
                    'SELECT aggregate_id, "year", "month", total_artist_detail_page_view_duration_seconds, total_artist_detail_page_views, score FROM v_artist_stats_report_current_month WHERE aggregate_id IN :aggregate_ids ORDER BY score DESC;'
                )
                artist_stats_report_records = session.exec(statement=statement,
                                                           params={
                                                               "aggregate_ids":
                                                                   aggregate_ids
                                                           }).all()
                return [
                    ArtistStatsReport(
                        aggregate_id=artist_stats_report_record[0],
                        year=artist_stats_report_record[1],
                        month=artist_stats_report_record[2],
                        total_artist_detail_page_view_duration_seconds=
                        artist_stats_report_record[3],
                        total_artist_detail_page_views=
                        artist_stats_report_record[4],
                        score=artist_stats_report_record[5]) for
                    artist_stats_report_record in artist_stats_report_records
                ]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
