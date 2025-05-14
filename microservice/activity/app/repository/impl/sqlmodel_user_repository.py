from app.repository.user_repository import (UserDataRepository,
                                            UserUsageDataRepository,
                                            UserPlaylistRepository,
                                            UserTrackRatingRepository,
                                            UserTrackRecommendationRepository)
from app.model.user import UserData, UserUsageData, UserPlaylist, UserTrackRating, UserTrackRecommendation
from sqlalchemy.exc import SQLAlchemyError
from contextlib import AbstractContextManager
from typing import Callable
from app.core.logger import Logger
from sqlmodel import Session, select, text
import uuid


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


class SqlmodelUserTrackRatingRepository(UserTrackRatingRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def find_last_half_year(self) -> list[UserTrackRating]:
        try:
            with self.session_factory() as session:
                statement = text(
                    'SELECT user_id, track_id, rating, total_listened_seconds FROM v_user_track_rating;'
                )
                user_track_rating_records = session.exec(
                    statement=statement).all()

                return [
                    UserTrackRating(
                        user_id=user_track_rating_record[0],
                        track_id=user_track_rating_record[1],
                        rating=user_track_rating_record[2],
                        total_listened_seconds=user_track_rating_record[3])
                    for user_track_rating_record in user_track_rating_records
                ]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()


class SqlmodelUserTrackRecommendationRepository(
        UserTrackRecommendationRepository):

    def __init__(
        self, logger: Logger,
        session_factory: Callable[...,
                                  AbstractContextManager[Session]]) -> None:
        self.logger = logger
        self.session_factory = session_factory

    def find_id_by_user_id_and_current_month(self,
                                             user_id: str) -> uuid.UUID | None:
        try:
            with self.session_factory() as session:
                statement = text('''SELECT id FROM user_track_recommendation 
                WHERE user_id = :user_id AND EXTRACT(MONTH FROM created_at) = EXTRACT(MONTH FROM current_timestamp) 
                AND EXTRACT(YEAR FROM created_at) = EXTRACT(YEAR FROM current_timestamp);'''
                                )
                user_track_recommendation_id_record = session.exec(
                    statement=statement, params={
                        "user_id": user_id
                    }).first()
                if not user_track_recommendation_id_record:
                    return None
                return user_track_recommendation_id_record[0]
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def save_user_track_recommendation(
        self, user_track_recommendation: UserTrackRecommendation
    ) -> UserTrackRecommendation | None:
        try:
            with self.session_factory() as session:
                session.add(user_track_recommendation)
                session.commit()
                session.refresh(user_track_recommendation)
                session.expunge_all()
                return user_track_recommendation
        except SQLAlchemyError as e:
            session.rollback()
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_id(self, id: uuid.UUID) -> UserTrackRecommendation | None:
        try:
            with self.session_factory() as session:
                statement = (select(UserTrackRecommendation).filter(
                    UserTrackRecommendation.id == id))
                user_track_recommendation = session.exec(statement).first()
                return user_track_recommendation
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()

    def find_by_user_id(self, user_id: str) -> UserTrackRecommendation | None:
        try:
            with self.session_factory() as session:
                statement = (select(UserTrackRecommendation).filter(
                    UserTrackRecommendation.user_id == user_id))
                user_track_recommendation = session.exec(statement).first()
                return user_track_recommendation
        except SQLAlchemyError as e:
            self.logger.error(f"{e}")
            raise e
        finally:
            session.close()
