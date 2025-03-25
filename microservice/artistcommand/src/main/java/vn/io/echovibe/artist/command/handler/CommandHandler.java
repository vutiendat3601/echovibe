package vn.io.echovibe.artist.command.handler;

import org.springframework.lang.NonNull;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.DeleteArtistCommand;
import vn.io.echovibe.artist.command.model.ReleaseArtistCommand;
import vn.io.echovibe.artist.command.model.SetArtistVerificationCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;

public interface CommandHandler {
  void handle(@NonNull CreateArtistCommand createArtistCommand);

  void handle(@NonNull UpdateArtistCommand updateArtistCommand);

  void handle(@NonNull ReleaseArtistCommand releaseArtistCommand);

  void handle(@NonNull DeleteArtistCommand deleteArtistCommand);

  void handle(@NonNull SetArtistVerificationCommand setArtistVerificationCommand);
}
