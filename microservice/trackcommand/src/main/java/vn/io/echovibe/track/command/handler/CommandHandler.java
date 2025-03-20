package vn.io.echovibe.track.command.handler;

import org.springframework.lang.NonNull;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.SetTrackVisibilityCommand;
import vn.io.echovibe.track.command.model.UpdateTrackDetailCommand;

public interface CommandHandler {
  void handle(@NonNull CreateTrackCommand createArtistCommand);

  void handle(@NonNull UpdateTrackDetailCommand updateArtistCommand);

  void handle(@NonNull ReleaseTrackCommand publishArtistCommand);

  void handle(@NonNull DeleteTrackCommand deleteArtistCommand);

  void handle(@NonNull SetTrackVisibilityCommand setTrackVisibilityCommand);
}
