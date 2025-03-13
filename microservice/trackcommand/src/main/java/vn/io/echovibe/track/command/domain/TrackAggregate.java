package vn.io.echovibe.track.command.domain;

import static vn.io.echovibe.track.common.constant.TrackConstant.TRACK_URN_PREFIX;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.AggregateIllegalStateException;
import vn.io.echovibe.core.exception.NoneFieldChangedException;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;
import vn.io.echovibe.track.common.event.TrackCreatedEvent;
import vn.io.echovibe.track.common.event.TrackDeletedEvent;
import vn.io.echovibe.track.common.event.TrackReleasedEvent;
import vn.io.echovibe.track.common.event.TrackUpdatedEvent;
import vn.io.echovibe.track.common.event.TrackVisibilityChangedEvent;

@Getter
@NoArgsConstructor
public class TrackAggregate extends AggregateRoot {
  private String urn;

  private String name;

  private String description;

  private Boolean isReleased;

  private Boolean isPublic;

  private Boolean isActive;

  private String thumbnailFileKey;

  private String thumbnailUrl;

  private List<String> artistIds;

  private List<String> tags;

  private String refCode;

  public TrackAggregate(CreateTrackCommand createTrackCommand) {
    final String urn = TRACK_URN_PREFIX + createTrackCommand.getId();
    // TODO: Call RESTful API to validate artistIds
    final TrackCreatedEvent trackCreatedEvent =
        TrackCreatedEvent.builder()
            .id(createTrackCommand.getId())
            .urn(urn)
            .name(createTrackCommand.getName())
            .description(createTrackCommand.getDescription())
            .isReleased(false)
            .isPublic(false)
            .isActive(true)
            .thumbnailUrl(createTrackCommand.getThumbnailUrl())
            .artistIds(createTrackCommand.getArtistIds())
            .refCode(createTrackCommand.getRefCode())
            .build();
    raiseEvent(trackCreatedEvent);
  }

  public void setIsPublic(Boolean isPublic) {
    if (Objects.nonNull(isPublic) && isPublic.equals(this.isPublic)) {
      throw new NoneFieldChangedException(
          "Track's visiblity of hasn't changed: aggregateId=%s, isPublic=%s"
              .formatted(id, isPublic));
    }
    final Boolean isReleased = Optional.of(this.isReleased).orElse(false);
    if (!isReleased) {
      throw new AggregateIllegalStateException(
          "To make the track's visibility public, it is required to be released: aggregateId=%s, isPublic=%s, isReleased=%s"
              .formatted(id, isPublic, isReleased));
    }
    final TrackVisibilityChangedEvent trackVisibilityChangedEvent =
        TrackVisibilityChangedEvent.builder().id(id).isPublic(isPublic).build();
    raiseEvent(trackVisibilityChangedEvent);
  }

  public void update(UpdateTrackCommand updateTrackCommand) {
    final String name = updateTrackCommand.getName();
    final String thumbnailUrl = updateTrackCommand.getThumbnailUrl();
    boolean hasChange = false;
    final TrackUpdatedEvent trackUpdatedEvent =
        TrackUpdatedEvent.builder()
            .id(id)
            .name(this.name)
            .thumbnailUrl(this.thumbnailUrl)
            .refCode(this.refCode)
            .build();
    // name
    if (!Objects.isNull(name) && !name.equals(trackUpdatedEvent.getName())) {
      hasChange = true;
      trackUpdatedEvent.setName(name);
    }
    // thumbnailUrl
    if (!Objects.isNull(thumbnailUrl)
        && !thumbnailUrl.equals(trackUpdatedEvent.getThumbnailUrl())) {
      hasChange = true;
      trackUpdatedEvent.setThumbnailUrl(thumbnailUrl);
    }
    // refCode
    if (!Objects.isNull(refCode) && !refCode.equals(trackUpdatedEvent.getRefCode())) {
      hasChange = true;
      trackUpdatedEvent.setRefCode(refCode);
    }
    if (!hasChange) {
      throw new NoneFieldChangedException();
    }
    raiseEvent(trackUpdatedEvent);
  }

  public void release() {
    if (Objects.nonNull(isReleased) && isReleased) {
      throw new AggregateIllegalStateException(
          "Track has already been released: aggregateId=%s".formatted(id));
    }
    final TrackReleasedEvent trackReleasedEvent =
        TrackReleasedEvent.builder()
            .id(id)
            .isPublished(true)
            .urn(urn)
            .name(name)
            .isPublic(isPublic)
            .isActive(true)
            .thumbnailFileKey(thumbnailFileKey)
            .thumbnailUrl(thumbnailUrl)
            .tags(tags)
            .refCode(refCode)
            .build();
    raiseEvent(trackReleasedEvent);
  }

  public void delete() {
    if (!Objects.nonNull(this.isActive) && !this.isActive) {
      throw new AggregateIllegalStateException(
          "Track has already been deleted: aggregateId=%s".formatted(id));
    }
    final Boolean isSoftDeleted = Optional.ofNullable(isReleased).orElse(false);
    final TrackDeletedEvent trackDeletedEvent =
        TrackDeletedEvent.builder().id(id).isSoftDeleted(isSoftDeleted).isActive(false).build();
    raiseEvent(trackDeletedEvent);
  }

  void apply(TrackCreatedEvent trackCreatedEvent) {
    this.id = trackCreatedEvent.getId();
    this.urn = trackCreatedEvent.getUrn();
    this.name = trackCreatedEvent.getName();
    this.isPublic = trackCreatedEvent.getIsPublic();
    this.isActive = trackCreatedEvent.getIsActive();
    this.isReleased = trackCreatedEvent.getIsReleased();
    this.refCode = trackCreatedEvent.getRefCode();
    this.tags = trackCreatedEvent.getTags();
    this.refCode = trackCreatedEvent.getRefCode();
  }

  void apply(TrackUpdatedEvent trackUpdatedEvent) {
    this.id = trackUpdatedEvent.getId();
    this.name = trackUpdatedEvent.getName();
    this.thumbnailUrl = trackUpdatedEvent.getThumbnailUrl();
    this.refCode = trackUpdatedEvent.getRefCode();
  }

  void apply(TrackReleasedEvent trackReleasedEvent) {
    this.id = trackReleasedEvent.getId();
    this.isReleased = trackReleasedEvent.getIsPublished();
  }

  void apply(TrackDeletedEvent trackDeletedEvent) {
    this.id = trackDeletedEvent.getId();
    this.isActive = trackDeletedEvent.getIsActive();
  }

  void apply(TrackVisibilityChangedEvent trackVisibilityChangedEvent) {
    this.id = trackVisibilityChangedEvent.getId();
    this.isPublic = trackVisibilityChangedEvent.getIsPublic();
  }
}
