from abc import ABC, abstractmethod
from app.model.user import (UserData, UserUsageData, UserPlaylist)


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
