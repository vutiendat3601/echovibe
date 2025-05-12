from abc import ABC, abstractmethod
from app.model.artist import (ArtistLike, ArtistDetailPageView, ArtistStats,
                              ArtistStatsDetail, ArtistRecommendation)


class ArtistLikeRepository(ABC):

    @abstractmethod
    def save_artist_like(self, artist_like: ArtistLike) -> ArtistLike:
        """Save ArtistLike"""

    def find_by_aggregate_id_and_user_id(self, aggregate_id: str,
                                         user_id: str) -> ArtistLike | None:
        """Find ArtistLike by aggregate_id and user_id"""


class ArtistDetailPageViewRepository(ABC):

    @abstractmethod
    def save_artist_detail_page_view(
            self, artist_detail_page_view: ArtistDetailPageView
    ) -> ArtistDetailPageView:
        """Save ArtistDetailPageView"""

    @abstractmethod
    def exist_by_session_id(self, session_id: str) -> bool:
        """Exist any ArtistDetailPageView by session_id"""

    @abstractmethod
    def find_by_session_id(self,
                           session_id: str) -> ArtistDetailPageView | None:
        """Find ArtistDetailPageView by session_id"""


class ArtistStatsRepository(ABC):

    @abstractmethod
    def save_artist_stats(self, artist_stats: ArtistStats) -> ArtistStats:
        """Save ArtistStats"""

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> ArtistStats | None:
        """Find ArtistStats by aggregate_id"""


class ArtistRecommendationRepository(ABC):

    @abstractmethod
    def save_artist_recommendation(
            self, artist_recommendation: ArtistRecommendation
    ) -> ArtistRecommendation:
        """Save ArtistRecommendation"""

    @abstractmethod
    def find_by_aggregate_id(self,
                             aggregate_id: str) -> ArtistRecommendation | None:
        """Find ArtistRecommendation by aggregate_id"""


class ArtistStatsDetailRepository(ABC):

    @abstractmethod
    def find_by_aggregate_id(self,
                             aggregate_id: str) -> ArtistStatsDetail | None:
        """Find ArtistStatsDetail by aggregate_id"""
