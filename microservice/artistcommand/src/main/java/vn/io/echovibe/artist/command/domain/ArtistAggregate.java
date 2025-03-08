package vn.io.echovibe.artist.command.domain;

import static vn.io.echovibe.artist.command.constant.ArtistConstant.ARTIST_URN_PREFIX;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;
import vn.io.echovibe.artist.common.event.ArtistCreatedEvent;
import vn.io.echovibe.artist.common.event.ArtistDeletedEvent;
import vn.io.echovibe.artist.common.event.ArtistPublishedEvent;
import vn.io.echovibe.artist.common.event.ArtistUpdatedEvent;
import vn.io.echovibe.artist.common.event.ArtistVisibilityChangedEvent;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.AggregateIllegalStateException;
import vn.io.echovibe.core.exception.NoneFieldChangedException;

@Getter
@NoArgsConstructor
public class ArtistAggregate extends AggregateRoot {
  private String urn;

  private String name;

  private String biography;

  private String description;

  private Boolean isPublished;

  private Boolean isPublic;

  private Boolean isActive;

  private String thumbnailFileKey;

  private String thumbnailUrl;

  private String backgroundFileKey;

  private String backgroundUrl;

  private List<String> tags;

  private String refCode;

  public ArtistAggregate(CreateArtistCommand createArtistCommand) {
    final String urn = ARTIST_URN_PREFIX + createArtistCommand.getId();
    final ArtistCreatedEvent artistCreatedEvent =
        ArtistCreatedEvent.builder()
            .id(createArtistCommand.getId())
            .urn(urn)
            .name(createArtistCommand.getName())
            .biography(createArtistCommand.getBiography())
            .description(createArtistCommand.getDescription())
            .isPublished(false)
            .isPublic(false)
            .isActive(true)
            .thumbnailUrl(createArtistCommand.getThumbnailUrl())
            .backgroundUrl(createArtistCommand.getBackgroundUrl())
            .refCode(createArtistCommand.getRefCode())
            .build();
    raiseEvent(artistCreatedEvent);
  }

  public void setIsPublic(Boolean isPublic) {
    if (Objects.nonNull(isPublic) && isPublic.equals(this.isPublic)) {
      throw new AggregateIllegalStateException(
          "Visiblity of artist hasn't changed: aggregateId=%s, isPublic=%s"
              .formatted(id, isPublic));
    }
    final Boolean isPublished = Optional.of(this.isPublished).orElse(false);
    if (!isPublished) {
      throw new AggregateIllegalStateException(
          "To make the artist's visibility public, it is required to be published: aggregateId=%s, isPublic=%s, isPublished=%s"
              .formatted(id, isPublic, isPublished));
    }
    final ArtistVisibilityChangedEvent artistVisibilityChangedEvent =
        ArtistVisibilityChangedEvent.builder().id(id).isPublic(isPublic).build();
    raiseEvent(artistVisibilityChangedEvent);
  }

  public void update(UpdateArtistCommand updateArtistCommand) {
    final String name = updateArtistCommand.getName();
    final String biography = updateArtistCommand.getBiography();
    final String description = updateArtistCommand.getDescription();
    final String thumbnailUrl = updateArtistCommand.getThumbnailUrl();
    final String backgroundUrl = updateArtistCommand.getBackgroundUrl();
    boolean hasChange = false;
    final ArtistUpdatedEvent artistUpdatedEvent =
        ArtistUpdatedEvent.builder()
            .id(id)
            .name(this.name)
            .biography(this.biography)
            .description(this.description)
            .thumbnailUrl(this.thumbnailUrl)
            .backgroundUrl(this.backgroundUrl)
            .refCode(this.refCode)
            .build();
    // name
    if (!Objects.isNull(name) && !name.equals(artistUpdatedEvent.getName())) {
      hasChange = true;
      artistUpdatedEvent.setName(name);
    }
    // biography
    if (!Objects.isNull(biography) && !biography.equals(artistUpdatedEvent.getBiography())) {
      hasChange = true;
      artistUpdatedEvent.setBiography(biography);
    }
    // description
    if (!Objects.isNull(description) && !description.equals(artistUpdatedEvent.getDescription())) {
      hasChange = true;
      artistUpdatedEvent.setDescription(description);
    }
    // thumbnailUrl
    if (!Objects.isNull(thumbnailUrl)
        && !thumbnailUrl.equals(artistUpdatedEvent.getThumbnailUrl())) {
      hasChange = true;
      artistUpdatedEvent.setThumbnailUrl(thumbnailUrl);
    }
    // backgroundUrl
    if (!Objects.isNull(backgroundUrl)
        && !backgroundUrl.equals(artistUpdatedEvent.getBackgroundUrl())) {
      hasChange = true;
      artistUpdatedEvent.setBackgroundUrl(backgroundUrl);
    }
    // refCode
    if (!Objects.isNull(refCode) && !refCode.equals(artistUpdatedEvent.getRefCode())) {
      hasChange = true;
      artistUpdatedEvent.setBackgroundUrl(refCode);
    }
    if (!hasChange) {
      throw new NoneFieldChangedException();
    }
    raiseEvent(artistUpdatedEvent);
  }

  public void publish() {
    if (Objects.nonNull(isPublished) && isPublished) {
      throw new AggregateIllegalStateException(
          "Artist has already been published: aggregateId=%s".formatted(id));
    }
    final ArtistPublishedEvent artistPublishedEvent =
        ArtistPublishedEvent.builder()
            .id(id)
            .isPublished(true)
            .urn(urn)
            .name(name)
            .biography(biography)
            .description(description)
            .isPublic(isPublic)
            .isActive(true)
            .thumbnailFileKey(thumbnailFileKey)
            .thumbnailUrl(thumbnailUrl)
            .backgroundFileKey(backgroundFileKey)
            .backgroundUrl(backgroundUrl)
            .tags(tags)
            .refCode(refCode)
            .build();
    raiseEvent(artistPublishedEvent);
  }

  public void delete() {
    if (!Objects.nonNull(this.isActive) && !this.isActive) {
      throw new AggregateIllegalStateException(
          "Artist has already been deleted: aggregateId=%s".formatted(id));
    }
    final Boolean isSoftDeleted = Optional.ofNullable(isPublished).orElse(false);
    final ArtistDeletedEvent artistDeletedEvent =
        ArtistDeletedEvent.builder().id(id).isSoftDeleted(isSoftDeleted).isActive(false).build();
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
    this.refCode = artistCreatedEvent.getRefCode();
    this.tags = artistCreatedEvent.getTags();
    this.refCode = artistCreatedEvent.getRefCode();
  }

  void apply(ArtistUpdatedEvent artistUpdatedEvent) {
    this.id = artistUpdatedEvent.getId();
    this.name = artistUpdatedEvent.getName();
    this.biography = artistUpdatedEvent.getBiography();
    this.description = artistUpdatedEvent.getDescription();
    this.thumbnailUrl = artistUpdatedEvent.getThumbnailUrl();
    this.backgroundUrl = artistUpdatedEvent.getBackgroundUrl();
    this.refCode = artistUpdatedEvent.getRefCode();
  }

  void apply(ArtistPublishedEvent artistPublishedEvent) {
    this.id = artistPublishedEvent.getId();
    this.isPublished = artistPublishedEvent.getIsPublished();
  }

  void apply(ArtistDeletedEvent artistDeletedEvent) {
    this.id = artistDeletedEvent.getId();
    this.isActive = artistDeletedEvent.getIsActive();
  }

  void apply(ArtistVisibilityChangedEvent artistVisibilityChangedEvent) {
    this.id = artistVisibilityChangedEvent.getId();
    this.isPublic = artistVisibilityChangedEvent.getIsPublic();
  }
}
