from abc import ABC, abstractmethod
from app.model.user import UserData, UserStats


class UserDataRepository(ABC):

    @abstractmethod
    def save_user_data(self, user_data: UserData) -> UserData:
        """Save UserData"""


class UserStatsRepository(ABC):

    @abstractmethod
    def find_by_user_id(self, user_id: str) -> UserStats | None:
        """Find UserStats by user_id"""
