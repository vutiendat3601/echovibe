package vn.io.echovibe.playlist.command.constant;

import java.util.Set;
import vn.io.echovibe.playlist.command.model.CreatePlaylistCommand;

public interface PlaylistCommandConstant {
  Set<String> HIDE_ID_WHEN_ERROR_COMMANDS = Set.of(CreatePlaylistCommand.class.getSimpleName());
}
