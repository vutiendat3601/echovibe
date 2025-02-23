package vn.io.echovibe.artist.command.handler;

import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import vn.io.echovibe.artist.command.domain.ArtistAggregate;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.DeleteArtistCommand;
import vn.io.echovibe.artist.command.model.PublishArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;
import vn.io.echovibe.core.event.EventSourcingHandler;
import vn.io.echovibe.core.exception.AggregateNotFoundException;

@RequiredArgsConstructor
@Service
public class ArtistCommandHandler implements CommandHandler {
  private final EventSourcingHandler<ArtistAggregate> eventSourcingHandler;

  @Override
  public void handle(CreateArtistCommand createArtistCommand) {
    final ArtistAggregate artistAggregate = new ArtistAggregate(createArtistCommand);
    eventSourcingHandler.save(artistAggregate);
  }

  @Override
  public void handle(UpdateArtistCommand updateArtistCommand) {
    final ArtistAggregate artistAggregate = findArtistAggregateById(updateArtistCommand.getId());
    artistAggregate.update(
        updateArtistCommand.getName(),
        updateArtistCommand.getDescription(),
        updateArtistCommand.getIsPublic());
    eventSourcingHandler.save(artistAggregate);
  }

  @Override
  public void handle(PublishArtistCommand publishArtistCommand) {
    final ArtistAggregate artistAggregate = findArtistAggregateById(publishArtistCommand.getId());
    artistAggregate.publish();
    eventSourcingHandler.save(artistAggregate);
  }

  @Override
  public void handle(DeleteArtistCommand deleteArtistCommand) {
    final ArtistAggregate artistAggregate = findArtistAggregateById(deleteArtistCommand.getId());
    artistAggregate.delete();
    eventSourcingHandler.save(artistAggregate);
  }

  private ArtistAggregate findArtistAggregateById(@NonNull String id) {
    final ArtistAggregate artistAggregate = eventSourcingHandler.findById(id);
    final boolean isActive = Optional.ofNullable(artistAggregate.getIsActive()).orElse(true);
    if (!isActive) {
      throw new AggregateNotFoundException("Artist not found: id=%s".formatted(id));
    }
    return artistAggregate;
  }
}
