package vn.io.echovibe.artist.command.handler;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vn.io.echovibe.artist.command.domain.ArtistAggregate;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;
import vn.io.echovibe.core.event.EventSourcingHandler;

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
    final ArtistAggregate artistAggregate =
        eventSourcingHandler.findById(updateArtistCommand.getId());
    artistAggregate.update(
        updateArtistCommand.getName(),
        updateArtistCommand.getDescription(),
        updateArtistCommand.getIsPublic());
    eventSourcingHandler.save(artistAggregate);
  }
}
