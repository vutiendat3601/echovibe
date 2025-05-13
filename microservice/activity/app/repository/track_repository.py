from abc import ABC, abstractmethod
from app.model.track import TrackLike, TrackDetailPageView, TrackListen, TrackStats, TrackStatsReport


class TrackLikeRepository(ABC):

    @abstractmethod
    def save_track_like(self, track_like: TrackLike) -> TrackLike:
        """Save TrackLike"""

    @abstractmethod
    def find_by_aggregate_id_and_user_id(self, aggregate_id: str,
                                         user_id: str) -> TrackLike | None:
        """Find TrackLike by aggregate_id and user_id"""

    @abstractmethod
    def find_by_aggregate_id_and_user_id_and_is_active(
            self, aggregate_id: str, user_id: str,
            is_active: bool) -> TrackLike | None:
        """Find TrackLike by aggregate_id and user_id"""


class TrackDetailPageViewRepository(ABC):

    @abstractmethod
    def save_track_detail_page_view(
            self,
            track_detail_page_view: TrackDetailPageView) -> TrackDetailPageView:
        """Save TrackDetailPageView"""

    @abstractmethod
    def exist_by_session_id(self, session_id: str) -> bool:
        """Exist any TrackDetailPageView by session_id"""

    @abstractmethod
    def find_by_session_id(self, session_id: str) -> TrackDetailPageView | None:
        """Find TrackDetailPageView by session_id"""


class TrackListenRepository(ABC):

    @abstractmethod
    def save_track_listen(self, track_listen: TrackListen) -> TrackListen:
        """Save TrackListen"""

    @abstractmethod
    def exist_by_session_id(self, session_id: str) -> bool:
        """Exist any TrackListen by session_id"""

    @abstractmethod
    def find_by_session_id(self, session_id: str) -> TrackListen | None:
        """Find TrackListen by session_id"""


class TrackStatsRepository(ABC):

    @abstractmethod
    def save_track_stats(self, track_stats: TrackStats) -> TrackStats:
        """Save TrackStats"""

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> TrackStats | None:
        """Find TrackStats by aggregate_id"""


class TrackReportRepository(ABC):

    @abstractmethod
    def find_track_stats_report_order_by_average_score_desc(
            self, aggregate_ids: list[str]) -> list[TrackStatsReport]:
        """Save TrackStatsReport"""

    @abstractmethod
    def find_track_stats_report_order_by_total_track_listens_desc(
            self, aggregate_ids: list[str]) -> list[TrackStatsReport]:
        """Save TrackStatsReport"""

    @abstractmethod
    def find_track_current_month_stats_report_by_aggregate_ids_order_by_total_track_listens_desc(
            self, aggregate_ids: list[str]) -> list[TrackStatsReport]:
        """Save TrackStatsReport"""
