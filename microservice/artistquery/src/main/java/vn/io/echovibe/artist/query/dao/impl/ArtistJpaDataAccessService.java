package vn.io.echovibe.artist.query.dao.impl;

import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;
import vn.io.echovibe.artist.query.dao.ArtistDao;
import vn.io.echovibe.artist.query.entity.Artist;
import vn.io.echovibe.artist.query.repository.ArtistRepository;

@RequiredArgsConstructor
@Repository
public class ArtistJpaDataAccessService implements ArtistDao {
  private final ArtistRepository artistRepository;

  @Override
  @NonNull
  public Optional<Artist> selectArtistByAggregateIdAndIsActiveTrue(@NonNull String aggregateId) {
    return artistRepository.findByAggregateIdAndIsActiveTrue(aggregateId);
  }

  @Override
  public void insert(@NonNull Artist artist) {
    artistRepository.save(artist);
  }

  @Override
  public void update(@NonNull Artist artist) {
    artistRepository.save(artist);
  }
}
