package vn.io.echovibe.artist.dispatcher;

import vn.io.echovibe.artist.dto.CreateArtistDto;

public interface ArtistService {
  void createArtist(CreateArtistDto createArtistDto);
}
