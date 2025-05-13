from app.repository.track_repository import (TrackLikeRepository,
                                             TrackDetailPageViewRepository,
                                             TrackListenRepository,
                                             TrackStatsRepository,
                                             TrackReportRepository)
from app.model.track import (TrackLike, TrackDetailPageView, TrackListen,
                             TrackStats, TrackStatsReport)
from sqlalchemy.exc import SQLAlchemyError
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from sqlmodel import Session, select, text


class SqlmodelTrackLikeRepository(TrackLikeRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_track_like(self, track_like: TrackLike) -> None:
        try:
            with self.session_factory() as session:
                session.add(track_like)
                session.commit()
                session.refresh(track_like)
                session.expunge_all()
                return track_like
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id_and_user_id(self, aggregate_id: str,
                                         user_id: str) -> TrackLike | None:
        try:
            with self.session_factory() as session:
                statement = (select(TrackLike).filter(
                    TrackLike.aggregate_id == aggregate_id,
                    TrackLike.user_id == user_id))
                track_like = session.exec(statement).first()
                return track_like
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id_and_user_id_and_is_active(
            self, aggregate_id: str, user_id: str,
            is_active: bool) -> TrackLike | None:
        try:
            with self.session_factory() as session:
                statement = (select(TrackLike).filter(
                    TrackLike.aggregate_id == aggregate_id,
                    TrackLike.user_id == user_id,
                    TrackLike.is_active == is_active))
                track_like = session.exec(statement).first()
                return track_like
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelTrackDetailPageViewRepository(TrackDetailPageViewRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_track_detail_page_view(
            self, track_detail_page_view: TrackDetailPageView) -> None:
        try:
            with self.session_factory() as session:
                session.add(track_detail_page_view)
                session.commit()
                session.refresh(track_detail_page_view)
                session.expunge_all()
                return track_detail_page_view
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def exist_by_session_id(self, session_id: str) -> bool:
        try:
            with self.session_factory() as session:
                statement = (select(TrackDetailPageView).filter(
                    TrackDetailPageView.session_id == session_id))
                track_detail_page_view = session.exec(statement).first()
                return True if track_detail_page_view else False
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_session_id(self, session_id: str) -> TrackDetailPageView | None:
        try:
            with self.session_factory() as session:
                statement = (select(TrackDetailPageView).filter(
                    TrackDetailPageView.session_id == session_id))
                track_detail_page_view = session.exec(statement).first()
                return track_detail_page_view
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelTrackListenRepository(TrackListenRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_track_listen(self, track_listen: TrackListen) -> None:
        try:
            with self.session_factory() as session:
                session.add(track_listen)
                session.commit()
                session.refresh(track_listen)
                session.expunge_all()
                return track_listen
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def exist_by_session_id(self, session_id: str) -> bool:
        try:
            with self.session_factory() as session:
                statement = (select(TrackListen).filter(
                    TrackListen.session_id == session_id))
                track_detail_page_view = session.exec(statement).first()
                return True if track_detail_page_view else False
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_session_id(self, session_id: str) -> TrackListen | None:
        try:
            with self.session_factory() as session:
                statement = (select(TrackListen).filter(
                    TrackListen.session_id == session_id))
                track_listen = session.exec(statement).first()
                return track_listen
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelTrackStatsRepository(TrackStatsRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def save_track_stats(self, track_stats: TrackStats) -> None:
        try:
            with self.session_factory() as session:
                session.add(track_stats)
                session.commit()
                session.refresh(track_stats)
                session.expunge_all()
                return track_stats
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_aggregate_id(self, aggregate_id: str) -> TrackStats | None:
        try:
            with self.session_factory() as session:
                statement = (select(TrackStats).filter(
                    TrackStats.aggregate_id == aggregate_id))
                track_stats = session.exec(statement).first()
                return track_stats
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelTrackReportRepository(TrackReportRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def find_track_stats_report_order_by_average_score_desc(
            self, aggregate_ids: list[str]) -> list[TrackStatsReport]:
        try:
            with self.session_factory() as session:
                statement = text(
                    "SELECT aggregate_id, total_track_detail_page_view_duration_seconds, total_track_detail_page_views, total_track_listen_duration_seconds, total_track_listens FROM find_track_stats_report_order_by_avg_score_desc(:aggregate_ids);"
                )
                track_stats_report_records = session.exec(statement=statement,
                                                          params={
                                                              "aggregate_ids":
                                                                  aggregate_ids
                                                          }).all()

                return [
                    TrackStatsReport(
                        aggregate_id=track_stats_report_record[0],
                        year=-1,
                        month=-1,
                        total_track_detail_page_view_duration_seconds=
                        track_stats_report_record[1],
                        total_track_detail_page_views=track_stats_report_record[
                            2],
                        total_track_listen_duration_seconds=
                        track_stats_report_record[3],
                        total_track_listens=track_stats_report_record[4],
                        score=0)
                    for track_stats_report_record in track_stats_report_records
                ]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_track_stats_report_order_by_total_track_listens_desc(
            self, aggregate_ids: list[str]) -> list[TrackStatsReport]:
        try:
            with self.session_factory() as session:
                statement = text(
                    "SELECT aggregate_id, total_track_detail_page_view_duration_seconds, total_track_detail_page_views, total_track_listen_duration_seconds, total_track_listens FROM find_track_stats_report_order_by_total_track_listens_desc(:aggregate_ids);"
                )
                track_stats_report_records = session.exec(statement=statement,
                                                          params={
                                                              "aggregate_ids":
                                                                  aggregate_ids
                                                          }).all()

                return [
                    TrackStatsReport(
                        aggregate_id=track_stats_report_record[0],
                        year=-1,
                        month=-1,
                        total_track_detail_page_view_duration_seconds=
                        track_stats_report_record[1],
                        total_track_detail_page_views=track_stats_report_record[
                            2],
                        total_track_listen_duration_seconds=
                        track_stats_report_record[3],
                        total_track_listens=track_stats_report_record[4],
                        score=0)
                    for track_stats_report_record in track_stats_report_records
                ]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_track_current_month_stats_report_by_aggregate_ids_order_by_total_track_listens_desc(
            self, aggregate_ids: list[str]) -> list[TrackStatsReport]:
        try:
            with self.session_factory() as session:
                statement = text(
                    "SELECT aggregate_id, total_track_detail_page_view_duration_seconds, total_track_detail_page_views, total_track_listen_duration_seconds, total_track_listens FROM find_track_stats_report_order_by_total_track_listens_desc_cm(:aggregate_ids);"
                )
                track_stats_report_records = session.exec(statement=statement,
                                                          params={
                                                              "aggregate_ids":
                                                                  aggregate_ids
                                                          }).all()

                return [
                    TrackStatsReport(
                        aggregate_id=track_stats_report_record[0],
                        year=-1,
                        month=-1,
                        total_track_detail_page_view_duration_seconds=
                        track_stats_report_record[1],
                        total_track_detail_page_views=track_stats_report_record[
                            2],
                        total_track_listen_duration_seconds=
                        track_stats_report_record[3],
                        total_track_listens=track_stats_report_record[4],
                        score=0)
                    for track_stats_report_record in track_stats_report_records
                ]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
