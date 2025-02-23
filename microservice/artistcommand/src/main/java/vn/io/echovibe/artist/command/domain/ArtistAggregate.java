package vn.io.echovibe.artist.command.domain;

import static vn.io.echovibe.artist.command.constant.ArtistConstant.ARTIST_URN_PREFIX;

import java.util.List;
import java.util.Objects;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.artist.command.event.ArtistCreatedEvent;
import vn.io.echovibe.artist.command.event.ArtistDeletedEvent;
import vn.io.echovibe.artist.command.event.ArtistPublishedEvent;
import vn.io.echovibe.artist.command.event.ArtistUpdatedEvent;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.AggregateIllegalStateException;
import vn.io.echovibe.core.exception.NoneFieldChangedException;

@Getter
@NoArgsConstructor
public class ArtistAggregate extends AggregateRoot {
  private String urn;

  private String name;

  private Boolean isActive;

  private Boolean isPublic;

  private String description;

  private Boolean isPublished;

  private String thumbnailFileKey;

  private String backgroundFileKey;

  private List<String> tags;

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
    final ArtistUpdatedEvent artistUpdatedEvent =
        ArtistUpdatedEvent.builder()
            .id(id)
            .name(this.name)
            .description(this.description)
            .isPublic(this.isPublic)
            .build();
    if (!Objects.isNull(name) && !name.equals(artistUpdatedEvent.getName())) {
      hasChange = true;
      artistUpdatedEvent.setName(name);
    }
    if (!Objects.isNull(description) && !description.equals(artistUpdatedEvent.getDescription())) {
      hasChange = true;
      artistUpdatedEvent.setDescription(description);
    }

    if (!Objects.isNull(isPublic) && !isPublic.equals(artistUpdatedEvent.getIsPublic())) {
      hasChange = true;
      artistUpdatedEvent.setIsPublic(isPublic);
    }
    if (!hasChange) {
      throw new NoneFieldChangedException();
    }
    raiseEvent(artistUpdatedEvent);
  }

  public void publish() {
    if (Objects.nonNull(isPublished) && isPublished) {
      throw new AggregateIllegalStateException(
          "Artist has been published before: id=%s".formatted(id));
    }
    final ArtistPublishedEvent artistPublishedEvent =
        ArtistPublishedEvent.builder().id(id).isPublished(true).build();
    raiseEvent(artistPublishedEvent);
  }

  public void delete() {
    if (!Objects.nonNull(this.isActive) && !this.isActive) {
      throw new AggregateIllegalStateException("Artist has been deleted before: %s".formatted(id));
    }
    final ArtistDeletedEvent artistDeletedEvent =
        ArtistDeletedEvent.builder().id(id).isActive(false).build();
    raiseEvent(artistDeletedEvent);
  }

  void apply(ArtistCreatedEvent artistCreatedEvent) {
    this.id = artistCreatedEvent.getId();
    this.urn = artistCreatedEvent.getUrn();
    this.name = artistCreatedEvent.getName();
    this.description = artistCreatedEvent.getDescription();
    this.isPublic = artistCreatedEvent.getIsPublic();
    this.isActive = artistCreatedEvent.getIsActive();
    this.isPublished = artistCreatedEvent.getIsPublished();
    this.ref = artistCreatedEvent.getRef();
    this.tags = artistCreatedEvent.getTags();
  }

  void apply(ArtistUpdatedEvent artistUpdatedEvent) {
    this.id = artistUpdatedEvent.getId();
    this.name = artistUpdatedEvent.getName();
    this.description = artistUpdatedEvent.getDescription();
    this.isPublic = artistUpdatedEvent.getIsPublic();
  }

  void apply(ArtistPublishedEvent artistPublishedEvent) {
    this.id = artistPublishedEvent.getId();
    this.isPublished = artistPublishedEvent.getIsPublished();
  }

  void apply(ArtistDeletedEvent artistDeletedEvent) {
    this.id = artistDeletedEvent.getId();
    this.isActive = artistDeletedEvent.getIsActive();
  }
}
