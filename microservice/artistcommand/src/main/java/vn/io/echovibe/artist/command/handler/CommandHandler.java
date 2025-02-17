package vn.io.echovibe.artist.command.handler;

import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;

public interface CommandHandler {
  void handle(CreateArtistCommand createArtistCommand);

  void handle(UpdateArtistCommand updateArtistCommand);
}
