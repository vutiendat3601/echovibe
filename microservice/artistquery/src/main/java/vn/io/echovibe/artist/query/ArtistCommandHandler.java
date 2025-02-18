package vn.io.echovibe.artist.command;

public interface ArtistCommandHandler {
  void handle(CreateArtistCommand createArtistCommand);

  void handle(UpdateArtistCommand updateArtistCommand);
}
