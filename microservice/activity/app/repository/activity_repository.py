from abc import ABC, abstractmethod
from app.model.activity import Activity


class ActivityRepository(ABC):

    @abstractmethod
    def save_activity(self, activity: Activity) -> Activity:
        """Save Activity"""
