from app.repository.activity_repository import ActivityRepository
from app.repository.user_repository import (UserDataRepository,
                                            UserUsageDataRepository)
from datetime import datetime, timezone
from app.core.logger import Logger
from app.model.user import (UserData)
from app.schema.user_schema import UserUsageDataSchema
from app.mapper.user_mapper import map_to_user_usage_data_schema


class UserService:

    def __init__(self, activity_repository: ActivityRepository,
                 user_data_repository: UserDataRepository,
                 user_usage_data_repository: UserUsageDataRepository,
                 logger: Logger):
        self.activity_repository = activity_repository
        self.user_data_repository = user_data_repository
        self.user_usage_data_repository = user_usage_data_repository
        self.logger = logger

    def get_user_usage_data(self, user_id) -> UserUsageDataSchema:
        user_usage_data = self.user_usage_data_repository.find_by_user_id(
            user_id)
        if user_usage_data:
            return map_to_user_usage_data_schema(user_usage_data)
        return self._fallback_get_user_usage_data(user_id)

    def _fallback_get_user_usage_data(self,
                                      user_id: str) -> UserUsageDataSchema:
        created_at = datetime.now(timezone.utc)
        user_data = UserData(user_id=user_id,
                             created_at=created_at,
                             updated_at=created_at,
                             created_by=user_id,
                             updated_by=user_id,
                             data_json={})
        self.user_data_repository.save_user_data(user_data)
        return map_to_user_usage_data_schema(
            self.user_usage_data_repository.find_by_user_id(user_id))
