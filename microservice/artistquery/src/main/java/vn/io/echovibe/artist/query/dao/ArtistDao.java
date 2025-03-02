package vn.io.echovibe.artist.query.dao;

import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.lang.NonNull;
import vn.io.echovibe.artist.query.entity.Artist;

public interface ArtistDao {
  @NonNull
  Optional<Artist> selectArtistByAggregateIdAndIsActiveTrue(@NonNull String aggregateId);

  @NonNull
  Page<Artist> selectByIsActiveTrueOrderByUpdatedAt(Integer page, Integer size);

  void insert(@NonNull Artist artist);

  void update(@NonNull Artist artist);

  void delete(@NonNull String aggregateId);
}
