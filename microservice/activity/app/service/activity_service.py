from app.repository.activity_repository import ActivityRepository
from datetime import datetime, timezone
from app.core.logger import Logger
from app.model.activity import Activity
from app.schema.activity_schema import CreateActivitySchema
from app.constant.constant import AUTH_SYSTEM_USERNAME


class ActivityService:

    def __init__(self, activity_repository: ActivityRepository, logger: Logger):
        self.activity_repository = activity_repository
        self.logger = logger

    def handle_activity(self,
                        create_activity: CreateActivitySchema,
                        jwt_claims: dict = {}) -> None:
        created_at = datetime.now(timezone.utc)
        activity: Activity = Activity(
            description="description",
            type=create_activity.type,
            data_json=create_activity.data_json,
            created_at=created_at,
            created_by=jwt_claims.get("sub")
            if jwt_claims and jwt_claims.get("sub") else AUTH_SYSTEM_USERNAME,
        )
        self.activity_repository.save_activity(activity)
        self.logger.info(
            f"Activity saved: type={create_activity.type}, created_by={activity.created_by}, created_at={created_at}"
        )
