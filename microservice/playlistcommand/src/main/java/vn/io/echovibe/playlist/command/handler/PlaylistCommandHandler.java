package vn.io.echovibe.playlist.command.handler;

import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import vn.io.echovibe.core.event.EventSourcingHandler;
import vn.io.echovibe.core.exception.AggregateNotFoundException;
import vn.io.echovibe.playlist.command.domain.PlaylistAggregate;
import vn.io.echovibe.playlist.command.model.ChangePlaylistVisibilityCommand;
import vn.io.echovibe.playlist.command.model.CreatePlaylistCommand;
import vn.io.echovibe.playlist.command.model.DeletePlaylistCommand;
import vn.io.echovibe.playlist.command.model.ReleasePlaylistCommand;
import vn.io.echovibe.playlist.command.model.UpdatePlaylistCommand;

@RequiredArgsConstructor
@Service
public class PlaylistCommandHandler implements CommandHandler {
  private final EventSourcingHandler<PlaylistAggregate> eventSourcingHandler;

  @Override
  public void handle(@NonNull CreatePlaylistCommand createPlaylistCommand) {
    final PlaylistAggregate trackAggregate = new PlaylistAggregate(createPlaylistCommand);
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull UpdatePlaylistCommand updatePlaylistCommand) {
    final PlaylistAggregate trackAggregate =
        findPlaylistAggregateById(updatePlaylistCommand.getId());
    trackAggregate.update(updatePlaylistCommand);
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull ReleasePlaylistCommand releasePlaylistCommand) {
    final PlaylistAggregate trackAggregate =
        findPlaylistAggregateById(releasePlaylistCommand.getId());
    trackAggregate.release();
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull DeletePlaylistCommand deletePlaylistCommand) {
    final PlaylistAggregate trackAggregate =
        findPlaylistAggregateById(deletePlaylistCommand.getId());
    trackAggregate.delete();
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull ChangePlaylistVisibilityCommand changePlaylistVisibilityCommand) {
    final PlaylistAggregate trackAggregate =
        findPlaylistAggregateById(changePlaylistVisibilityCommand.getId());
    trackAggregate.setIsPublic(changePlaylistVisibilityCommand.getIsPublic());
    eventSourcingHandler.save(trackAggregate);
  }

  private PlaylistAggregate findPlaylistAggregateById(@NonNull String id) {
    final PlaylistAggregate trackAggregate = eventSourcingHandler.findById(id);
    final boolean isActive = Optional.ofNullable(trackAggregate.getIsActive()).orElse(true);
    if (!isActive) {
      throw new AggregateNotFoundException("Playlist not found: aggregateId=%s".formatted(id));
    }
    return trackAggregate;
  }
}
