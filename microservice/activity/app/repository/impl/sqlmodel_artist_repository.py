from app.repository.artist_repository import (ArtistLikeRepository,
                                              ArtistDetailPageViewRepository,
                                              ArtistStatsRepository,
                                              ArtistRecommendationRepository,
                                              ArtistStatsDetailRepository)
from app.model.artist import (ArtistLike, ArtistDetailPageView, ArtistStats,
                              ArtistStatsDetail, ArtistRecommendation)
from sqlalchemy.exc import SQLAlchemyError
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from sqlmodel import Session
from sqlmodel import Session, select


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
