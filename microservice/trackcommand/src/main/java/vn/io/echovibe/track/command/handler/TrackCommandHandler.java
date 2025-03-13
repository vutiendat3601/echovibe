package vn.io.echovibe.track.command.handler;

import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import vn.io.echovibe.core.event.EventSourcingHandler;
import vn.io.echovibe.core.exception.AggregateNotFoundException;
import vn.io.echovibe.track.command.domain.TrackAggregate;
import vn.io.echovibe.track.command.model.ChangeTrackVisibilityCommand;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;

@RequiredArgsConstructor
@Service
public class TrackCommandHandler implements CommandHandler {
  private final EventSourcingHandler<TrackAggregate> eventSourcingHandler;

  @Override
  public void handle(@NonNull CreateTrackCommand createTrackCommand) {
    final TrackAggregate trackAggregate = new TrackAggregate(createTrackCommand);
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull UpdateTrackCommand updateTrackCommand) {
    final TrackAggregate trackAggregate = findTrackAggregateById(updateTrackCommand.getId());
    trackAggregate.update(updateTrackCommand);
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull ReleaseTrackCommand publishArtistCommand) {
    final TrackAggregate trackAggregate = findTrackAggregateById(publishArtistCommand.getId());
    trackAggregate.release();
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull DeleteTrackCommand deleteTrackCommand) {
    final TrackAggregate trackAggregate = findTrackAggregateById(deleteTrackCommand.getId());
    trackAggregate.delete();
    eventSourcingHandler.save(trackAggregate);
  }

  @Override
  public void handle(@NonNull ChangeTrackVisibilityCommand changeTrackVisibilityCommand) {
    final TrackAggregate trackAggregate =
        findTrackAggregateById(changeTrackVisibilityCommand.getId());
    trackAggregate.setIsPublic(changeTrackVisibilityCommand.getIsPublic());
    eventSourcingHandler.save(trackAggregate);
  }

  private TrackAggregate findTrackAggregateById(@NonNull String id) {
    final TrackAggregate trackAggregate = eventSourcingHandler.findById(id);
    final boolean isActive = Optional.ofNullable(trackAggregate.getIsActive()).orElse(true);
    if (!isActive) {
      throw new AggregateNotFoundException("Artist not found: aggregateId=%s".formatted(id));
    }
    return trackAggregate;
  }
}
