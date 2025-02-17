package vn.io.echovibe.artist.command.domain;

import static vn.io.echovibe.artist.command.constant.ArtistConstant.ARTIST_URN_PREFIX;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.artist.command.event.ArtistCreatedEvent;
import vn.io.echovibe.artist.command.event.ArtistUpdatedEvent;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.NoneFieldChangedException;

@Getter
@NoArgsConstructor
public class ArtistAggregate extends AggregateRoot {
  private String urn;

  private String name;

  private Boolean isPublic = false;

  private String description;

  private Boolean isActive = false;

  private String thumbnailFileKey;

  private String backgroundFileKey;

  private List<String> tags = new ArrayList<>();

  private String ref;

  public ArtistAggregate(CreateArtistCommand createArtistCommand) {
    final String urn = ARTIST_URN_PREFIX + createArtistCommand.getId();
    final ArtistCreatedEvent artistCreatedEvent =
        ArtistCreatedEvent.builder()
            .id(createArtistCommand.getId())
            .urn(urn)
            .name(createArtistCommand.getName())
            .description(createArtistCommand.getDescription())
            .isPublic(createArtistCommand.getIsPublic())
            .build();
    raiseEvent(artistCreatedEvent);
  }

  public void update(String name, String description, Boolean isPublic) {
    boolean hasChange = false;
    final ArtistUpdatedEvent artistUpdatedEvent = new ArtistUpdatedEvent();
    if (!Objects.isNull(name) && !name.equals(this.name)) {
      hasChange = true;
      artistUpdatedEvent.setName(name);
    }
    if (!Objects.isNull(description) && !description.equals(this.description)) {
      hasChange = true;
      artistUpdatedEvent.setDescription(description);
    }

    if (!Objects.isNull(isPublic) && !isPublic.equals(this.isPublic)) {
      hasChange = true;
      artistUpdatedEvent.setIsPublic(isPublic);
    }
    if (!hasChange) {
      throw new NoneFieldChangedException();
    }
    raiseEvent(artistUpdatedEvent);
  }

  void apply(ArtistCreatedEvent artistCreatedEvent) {
    this.id = artistCreatedEvent.getId();
    this.name = artistCreatedEvent.getName();
    this.description = artistCreatedEvent.getDescription();
    this.isPublic = artistCreatedEvent.getIsPublic();
  }

  void apply(ArtistUpdatedEvent artistUpdatedEvent) {
    this.id = artistUpdatedEvent.getId();
    this.name = artistUpdatedEvent.getName();
    this.description = artistUpdatedEvent.getDescription();
    this.isPublic = artistUpdatedEvent.getIsPublic();
  }
}
