package vn.io.echovibe.artist.command.handler;

import org.springframework.lang.NonNull;

import vn.io.echovibe.artist.command.model.ChangeArtistMarketCommand;
import vn.io.echovibe.artist.command.model.ChangeArtistVisibilityCommand;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.DeleteArtistCommand;
import vn.io.echovibe.artist.command.model.PublishArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;

public interface CommandHandler {
  void handle(@NonNull CreateArtistCommand createArtistCommand);

  void handle(@NonNull UpdateArtistCommand updateArtistCommand);

  void handle(@NonNull PublishArtistCommand publishArtistCommand);

  void handle(@NonNull DeleteArtistCommand deleteArtistCommand);

  void handle(@NonNull ChangeArtistVisibilityCommand changeArtistVisibilityCommand);

  void handle(@NonNull ChangeArtistMarketCommand changeArtistMarketCommand);
}
