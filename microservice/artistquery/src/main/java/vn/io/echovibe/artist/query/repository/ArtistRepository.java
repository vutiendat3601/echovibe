package vn.io.echovibe.artist.query.repository;

import java.util.Optional;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.lang.NonNull;
import vn.io.echovibe.artist.query.entity.Artist;

public interface ArtistRepository extends JpaRepository<Artist, UUID> {
  @NonNull
  Optional<Artist> findByAggregateIdAndIsActiveTrue(@NonNull String aggregateId);

  @NonNull
  Page<Artist> findByIsActiveTrueOrderByUpdatedAt(@NonNull Pageable pageable);

  void deleteByAggregateId(@NonNull String aggregateId);
}
