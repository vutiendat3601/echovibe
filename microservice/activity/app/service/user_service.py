from app.repository.activity_repository import ActivityRepository
from app.repository.user_repository import (UserDataRepository,
                                            UserUsageDataRepository,
                                            UserTrackRatingRepository,
                                            UserTrackRecommendationRepository)
from app.repository.track_repository import (TrackReportRepository)
from datetime import datetime, timezone
from app.model.user import (UserTrackRating, UserTrackRecommendation)
from app.core.logger import Logger
from app.model.user import (UserData)
from app.model.activity import Activity
from app.schema.user_schema import UserUsageDataSchema, UserRecommendationSchema
from app.mapper.user_mapper import map_to_user_usage_data_schema
import pandas
from sklearn.metrics.pairwise import cosine_similarity


class UserService:

    def __init__(self, activity_repository: ActivityRepository,
                 user_data_repository: UserDataRepository,
                 user_usage_data_repository: UserUsageDataRepository,
                 user_track_rating_repository: UserTrackRatingRepository,
                 track_report_repository: TrackReportRepository,
                 user_track_recommendation_repository:
                 UserTrackRecommendationRepository, logger: Logger):
        self.activity_repository = activity_repository
        self.user_data_repository = user_data_repository
        self.user_usage_data_repository = user_usage_data_repository
        self.user_track_rating_repository = user_track_rating_repository
        self.user_track_recommendation_repository = user_track_recommendation_repository
        self.track_report_repository = track_report_repository
        self.logger = logger

    async def get_user_usage_data(self, user_id) -> UserUsageDataSchema:
        user_usage_data = self.user_usage_data_repository.find_by_user_id(
            user_id)
        if user_usage_data:
            return map_to_user_usage_data_schema(user_usage_data)
        return await self._fallback_get_user_usage_data(user_id)

    async def _fallback_get_user_usage_data(
            self, user_id: str) -> UserUsageDataSchema:
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

    async def get_user_recommendation(self,
                                      user_id: str) -> UserUsageDataSchema:
        user_recommendation_schema = UserRecommendationSchema(user_id=user_id)
        user_track_recommendation = self.user_track_recommendation_repository.find_by_user_id(
            user_id)
        if user_track_recommendation:
            user_recommendation_schema.recommended_track_ids = user_track_recommendation.track_ids
        track_current_month_stats_reports = self.track_report_repository.find_track_current_month_stats_report_order_by_score_desc(
        )
        if track_current_month_stats_reports:
            user_recommendation_schema.most_popular_track_ids_current_month = [
                track_current_month_stats_report.aggregate_id
                for track_current_month_stats_report in
                track_current_month_stats_reports
            ]

        return user_recommendation_schema

    async def handle_viewed_search_result(self, activity: Activity):
        recent_search = activity.data_json.get("recentSearchs", [])
        user_data = self.user_data_repository.find_by_user_id(
            activity.created_by)
        created_at = datetime.now(timezone.utc)
        if not user_data:
            user_data = UserData(user_id=activity.created_by,
                                 data_json={},
                                 created_at=created_at,
                                 created_by=activity.created_by)
        user_data.recent_searchs_json = recent_search
        user_data.updated_at = created_at
        user_data.updated_by = activity.created_by
        self.user_data_repository.save_user_data(user_data)

    async def process_user_track_recommendation(self):
        predict_user_track_ratings = await self._process_user_track_collabrative_filtering(
        )
        user_ids_set = set([
            predict_user_track_rating.user_id
            for predict_user_track_rating in predict_user_track_ratings
        ])
        for user_id in user_ids_set:
            current_predict_user_track_ratings = list(
                filter(
                    lambda predict_user_track_rating: predict_user_track_rating.
                    user_id == user_id and predict_user_track_rating.rating > 1,
                    predict_user_track_ratings))
            id = self.user_track_recommendation_repository.find_id_by_user_id_and_current_month(
                user_id)
            user_track_recommendation = self.user_track_recommendation_repository.find_by_id(
                id) if id else None
            if not user_track_recommendation:
                user_track_recommendation = UserTrackRecommendation(
                    user_id=user_id, track_ids=[], ratings_json={})
            user_track_recommendation.track_ids = [
                user_track_rating.track_id
                for user_track_rating in current_predict_user_track_ratings
            ]
            user_track_recommendation.ratings_json = {
                "predictUserTrackRating": [{
                    "userId": predict_user_track_rating.user_id,
                    "trackId": predict_user_track_rating.track_id,
                    "rating": predict_user_track_rating.rating
                } for predict_user_track_rating in
                                           current_predict_user_track_ratings],
            }
            self.user_track_recommendation_repository.save_user_track_recommendation(
                user_track_recommendation)

    async def _process_user_track_collabrative_filtering(
            self) -> list[UserTrackRating]:
        user_track_ratings = self.user_track_rating_repository.find_last_half_year(
        )
        user_ids = [
            user_track_rating.user_id
            for user_track_rating in user_track_ratings
        ]
        track_ids = [
            user_track_rating.track_id
            for user_track_rating in user_track_ratings
        ]
        track_ratings = [
            user_track_rating.rating for user_track_rating in user_track_ratings
        ]
        df = pandas.DataFrame({
            "user_id": user_ids,
            "track_id": track_ids,
            "rating": track_ratings,
        })

        # Create user-track matrix
        user_track_rating_matrix = df.pivot_table(index='user_id',
                                                  columns='track_id',
                                                  values='rating').fillna(0)
        # Compute cosine similarity between users
        user_similarity = cosine_similarity(user_track_rating_matrix)
        user_similarity_df = pandas.DataFrame(
            user_similarity,
            index=user_track_rating_matrix.index,
            columns=user_track_rating_matrix.index)

        # Get similarity scores and other users' ratings
        user_track_ratings = []
        for user_id in user_track_rating_matrix.index:
            for track_id in user_track_rating_matrix.columns:
                if user_track_rating_matrix.loc[user_id, track_id] == 0:
                    predicted_rating = self._predict_rating(
                        user_id, track_id, user_similarity_df,
                        user_track_rating_matrix)
                    user_track_ratings.append(
                        UserTrackRating(user_id=user_id,
                                        track_id=track_id,
                                        rating=predicted_rating))
        return user_track_ratings

    def _predict_rating(self, user_id: str, track_id: str,
                        user_similarity_df: pandas.DataFrame,
                        user_track_rating_matrix: pandas.DataFrame):
        # Get similarity scores and other users' ratings
        sim_scores = user_similarity_df.loc[user_id].drop(user_id)
        track_ratings = user_track_rating_matrix[track_id].drop(user_id)

        # Mask out users who haven't rated the track
        mask = track_ratings > 0
        if mask.sum() == 0:
            return 0.0
        # Weighted sum of ratings
        weighted_sum = (sim_scores[mask] * track_ratings[mask]).sum()
        sim_sum = sim_scores[mask].sum()
        predicted = weighted_sum / sim_sum if sim_sum != 0 else 0.0
        # Clip prediction to 0–10 range
        return round(min(max(predicted, 0), 10), 2)
