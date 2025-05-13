from abc import ABC, abstractmethod
from app.model.user import (UserData, UserUsageData, UserPlaylist,
                            UserTrackRating, UserTrackRecommendation)
import uuid


class UserDataRepository(ABC):

    @abstractmethod
    def save_user_data(self, user_data: UserData) -> UserData:
        """Save UserData"""


class UserUsageDataRepository(ABC):

    @abstractmethod
    def find_by_user_id(self, user_id: str) -> UserUsageData | None:
        """Find UserStats by user_id"""


class UserPlaylistRepository(ABC):

    @abstractmethod
    def save_user_playlist(self, user_playlist: UserPlaylist) -> UserPlaylist:
        """Save UserPlaylist"""

    @abstractmethod
    def find_by_playlist_id_and_is_active(
            self, playlist_id: str, is_active: bool) -> UserPlaylist | None:
        """Find UserPlaylist by playlist_id"""


class UserTrackRatingRepository(ABC):

    @abstractmethod
    def find_last_half_year(self) -> list[UserTrackRating]:
        """Find UserTrackRating last half year"""


class UserTrackRecommendationRepository(ABC):

    @abstractmethod
    def find_id_by_user_id_and_current_month(
            self, user_id: str) -> UserTrackRecommendation | None:
        """Find UserTrackRecommendation by user_id"""

    @abstractmethod
    def find_by_id(self, id: uuid.UUID) -> UserTrackRecommendation | None:
        """Find UserTrackRecommendation by user_id"""

    @abstractmethod
    def save_user_track_recommendation(
        user_track_recommendation: UserTrackRecommendation
    ) -> UserTrackRecommendation:
        """Save UserTrackRecommendation"""
