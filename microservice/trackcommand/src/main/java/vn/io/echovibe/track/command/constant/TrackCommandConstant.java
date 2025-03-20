package vn.io.echovibe.track.command.constant;

import java.util.Set;
import vn.io.echovibe.track.command.model.CreateTrackCommand;

public interface TrackCommandConstant {
  Set<String> HIDE_ID_WHEN_ERROR_COMMANDS = Set.of(CreateTrackCommand.class.getSimpleName());
}
