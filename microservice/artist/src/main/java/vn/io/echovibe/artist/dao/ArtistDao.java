package vn.io.echovibe.artist.dao;

import java.util.Optional;
import java.util.UUID;
import org.springframework.lang.NonNull;
import vn.io.echovibe.artist.entity.Artist;

public interface ArtistDao {
  boolean existsArtistById(@NonNull UUID id);

  @NonNull
  Optional<Artist> selectArtistById(@NonNull UUID id);

  @NonNull
  Optional<Artist> insertArtist(@NonNull Artist artist);

  void updateArtist(@NonNull Artist artist);

  void deleteArtist(@NonNull UUID id);
}
