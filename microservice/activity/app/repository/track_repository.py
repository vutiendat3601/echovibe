from abc import ABC, abstractmethod
from app.model.track import TrackLike, TrackDetailPageView, TrackListen, TrackStats


class TrackLikeRepository(ABC):

    @abstractmethod
    def save_track_like(self, track_like: TrackLike) -> TrackLike:
        """Save TrackLike"""

    @abstractmethod
    def find_by_aggregate_id_and_user_id(self, aggregate_id: str,
                                         user_id: str) -> TrackLike | None:
        """Find TrackLike by aggregate_id and user_id"""


class TrackDetailPageViewRepository(ABC):

    @abstractmethod
    def save_track_detail_page_view(
            self,
            track_detail_page_view: TrackDetailPageView) -> TrackDetailPageView:
        """Save TrackDetailPageView"""


class TrackListenRepository(ABC):

    @abstractmethod
    def save_track_listen(self, track_listen: TrackListen) -> TrackListen:
        """Save TrackListen"""


class TrackStatsRepository(ABC):

    @abstractmethod
    def save_track_stats(self, track_stats: TrackStats) -> TrackStats:
        """Save TrackStats"""

    @abstractmethod
    def find_by_aggregate_id(self, aggregate_id: str) -> TrackStats | None:
        """Find TrackStats by aggregate_id"""
