package vn.io.echovibe.artist.dao.impl;

import java.util.Optional;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;
import vn.io.echovibe.artist.dao.ArtistDao;
import vn.io.echovibe.artist.entity.Artist;
import vn.io.echovibe.artist.repository.ArtistRepository;

@RequiredArgsConstructor
@Repository
public class ArtistJpaDataAccessService implements ArtistDao {
  private final ArtistRepository artistRepo;

  @Override
  @NonNull
  public Optional<Artist> insertArtist(@NonNull Artist artist) {
    return Optional.ofNullable(artistRepo.save(artist));
  }

  @Override
  public void updateArtist(@NonNull Artist artist) {
    artistRepo.save(artist);
  }

  @Override
  public void deleteArtist(@NonNull UUID id) {
    artistRepo.deleteById(id);
  }

  @Override
  public boolean existsArtistById(@NonNull UUID id) {
    return artistRepo.existsById(id);
  }

  @Override
  @NonNull
  public Optional<Artist> selectArtistById(@NonNull UUID id) {
    return artistRepo.findById(id);
  }
}
