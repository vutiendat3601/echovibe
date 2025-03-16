package vn.io.echovibe.playlist.command.handler;

import org.springframework.lang.NonNull;
import vn.io.echovibe.playlist.command.model.SetPlaylistVisibilityCommand;
import vn.io.echovibe.playlist.command.model.CreatePlaylistCommand;
import vn.io.echovibe.playlist.command.model.DeletePlaylistCommand;
import vn.io.echovibe.playlist.command.model.ReleasePlaylistCommand;
import vn.io.echovibe.playlist.command.model.UpdatePlaylistDetailCommand;

public interface CommandHandler {
  void handle(@NonNull CreatePlaylistCommand createArtistCommand);

  void handle(@NonNull UpdatePlaylistDetailCommand updateArtistCommand);

  void handle(@NonNull ReleasePlaylistCommand releaseArtistCommand);

  void handle(@NonNull DeletePlaylistCommand deleteArtistCommand);

  void handle(@NonNull SetPlaylistVisibilityCommand changeArtistVisibilityCommand);
}
