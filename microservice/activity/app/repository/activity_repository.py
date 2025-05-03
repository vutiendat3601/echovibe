from abc import ABC, abstractmethod
from app.model.activity import Activity


class ActivityRepository(ABC):

    @abstractmethod
    def save_activity(self, activity: Activity) -> Activity:
        """Save Activity"""

    def find_by_session_id() -> Activity | None:
        """Find Activity by session_id"""

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> Activity | None:
        """Find Activity by aggregate_id"""
