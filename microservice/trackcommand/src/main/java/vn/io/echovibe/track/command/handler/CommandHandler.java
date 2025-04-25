package vn.io.echovibe.track.command.handler;

import org.springframework.lang.NonNull;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.MapTrackAudioCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;

public interface CommandHandler {
  void handle(@NonNull CreateTrackCommand createTrackCommand);

  void handle(@NonNull UpdateTrackCommand updateTrackCommand);

  void handle(@NonNull ReleaseTrackCommand releaseTrackCommand);

  void handle(@NonNull DeleteTrackCommand deleteTrackCommand);

  void handle(@NonNull MapTrackAudioCommand mapTrackAudioCommand);
}
