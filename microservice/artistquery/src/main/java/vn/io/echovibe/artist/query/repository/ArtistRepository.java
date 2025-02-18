package vn.io.echovibe.artist.repository;

import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.io.echovibe.artist.command.entity.Artist;

public interface ArtistRepository extends JpaRepository<Artist, UUID> {}
