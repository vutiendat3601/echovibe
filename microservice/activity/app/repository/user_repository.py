from abc import ABC, abstractmethod
from app.model.user import UserData, UserUsageData


class UserDataRepository(ABC):

    @abstractmethod
    def save_user_data(self, user_data: UserData) -> UserData:
        """Save UserData"""


class UserUsageDataRepository(ABC):

    @abstractmethod
    def find_by_user_id(self, user_id: str) -> UserUsageData | None:
        """Find UserStats by user_id"""
