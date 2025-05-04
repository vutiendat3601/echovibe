from app.repository.activity_repository import ActivityRepository
from app.repository.user_repository import (UserDataRepository,
                                            UserStatsRepository)
from datetime import datetime, timezone
from app.enum.action_type import ActionType
from app.core.logger import Logger
from app.model.activity import Activity
from app.schema.activity_schema import ActivitySchema
from app.event.sender.event_sender import send_event
from app.enum.action_type import ActionType
from app.model.user import (UserData, UserStats)
from app.util.identity_utils import generate_aggregate_id
from app.schema.user_schema import UserStatsSchema
from app.mapper.user_mapper import map_to_user_stats_schema
from app.model.user import UserStats, UserData


class UserService:

    def __init__(self, activity_repository: ActivityRepository,
                 user_data_repository: UserDataRepository,
                 user_stats_repository: UserStatsRepository, logger: Logger):
        self.activity_repository = activity_repository
        self.user_data_repository = user_data_repository
        self.user_stats_repository = user_stats_repository
        self.logger = logger

    def get_user_stats(self, user_id) -> UserStatsSchema:
        user_stats = self.user_stats_repository.find_by_user_id(user_id)
        if user_stats:
            return map_to_user_stats_schema(user_stats)
        return self._fallback_get_user_stats(user_id)

    def _fallback_get_user_stats(self, user_id: str) -> UserStatsSchema:
        created_at = datetime.now(timezone.utc)
        user_data = UserData(user_id=user_id,
                             created_at=created_at,
                             updated_at=created_at,
                             created_by=user_id,
                             updated_by=user_id,
                             data_json={})
        self.user_data_repository.save_user_data(user_data)
        return map_to_user_stats_schema(
            self.user_stats_repository.find_by_user_id(user_id))
