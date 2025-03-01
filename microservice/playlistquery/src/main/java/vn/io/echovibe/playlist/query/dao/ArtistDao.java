package vn.io.echovibe.playlist.query.dao;

import java.util.Optional;
import org.springframework.lang.NonNull;
import vn.io.echovibe.artist.query.entity.Artist;

public interface ArtistDao {
  @NonNull
  Optional<Artist> selectArtistByAggregateIdAndIsActiveTrue(@NonNull String aggregateId);

  void insert(@NonNull Playlist artist);

  void update(@NonNull Playlist artist);
}
