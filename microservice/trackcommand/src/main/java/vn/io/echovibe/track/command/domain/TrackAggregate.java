package vn.io.echovibe.track.command.domain;

import static vn.io.echovibe.core.constant.BusinessRuleConstant.BR_01;
import static vn.io.echovibe.track.common.constant.TrackBusinessRuleConstant.TRACK_BR_01;
import static vn.io.echovibe.track.common.constant.TrackConstant.TRACK_URN_PREFIX;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.BusinessRuleViolationException;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackDetailCommand;
import vn.io.echovibe.track.common.event.TrackCreatedEvent;
import vn.io.echovibe.track.common.event.TrackDeletedEvent;
import vn.io.echovibe.track.common.event.TrackDetailUpdatedEvent;
import vn.io.echovibe.track.common.event.TrackReleasedEvent;
import vn.io.echovibe.track.common.event.TrackVisibilitySetEvent;
import vn.io.echovibe.track.common.model.TrackDetail;

@Getter
@NoArgsConstructor
public class TrackAggregate extends AggregateRoot {
  private String urn;

  private TrackDetail detail;

  private Boolean isReleased;

  private Boolean isPublic;

  private Boolean isActive;

  private List<String> artistIds;

  private List<String> tags;

  public TrackAggregate(CreateTrackCommand createTrackCommand) {
    final String urn = TRACK_URN_PREFIX + createTrackCommand.getId();
    // TODO: Call RESTful API to validate artistIds
    final TrackCreatedEvent trackCreatedEvent =
        TrackCreatedEvent.builder()
            .id(createTrackCommand.getId())
            .urn(urn)
            .detail(createTrackCommand.getDetail())
            .artistIds(createTrackCommand.getArtistIds())
            .isReleased(false)
            .isPublic(false)
            .isActive(true)
            .artistIds(createTrackCommand.getArtistIds())
            .build();
    raiseEvent(trackCreatedEvent);
  }

  public void setIsPublic(Boolean isPublic) {
    if (Objects.nonNull(isPublic) && isPublic.equals(this.isPublic)) {
      throw new BusinessRuleViolationException(
          BR_01,
          "Track's visiblity has no changes: aggregateId=%s, isPublic=%s".formatted(id, isPublic));
    }
    final TrackVisibilitySetEvent trackVisibilityChangedEvent =
        TrackVisibilitySetEvent.builder().id(id).isPublic(isPublic).build();
    raiseEvent(trackVisibilityChangedEvent);
  }

  public void update(UpdateTrackDetailCommand updateTrackDetailCommand) {
    final TrackDetail updateDetail = updateTrackDetailCommand.getDetail();

    boolean hasChange = false;
    final TrackDetail updatedDetail =
        TrackDetail.builder()
            .name(this.detail.getName())
            .description(this.detail.getDescription())
            .thumbnailFileKey(this.detail.getThumbnailFileKey())
            .thumbnailUrl(this.detail.getThumbnailUrl())
            .refCode(this.detail.getRefCode())
            .build();

    // name
    if (!Objects.equals(updateDetail.getName(), updatedDetail.getName())) {
      hasChange = true;
      updatedDetail.setName(updateDetail.getName());
    }
    // description
    if (!Objects.equals(updateDetail.getDescription(), updatedDetail.getDescription())) {
      hasChange = true;
      updatedDetail.setName(updateDetail.getDescription());
    }
    // thumbnailUrl
    if (!Objects.equals(updateDetail.getThumbnailUrl(), updatedDetail.getThumbnailUrl())) {
      hasChange = true;
      updatedDetail.setThumbnailUrl(updateDetail.getThumbnailUrl());
    }
    // refCode
    if (!Objects.equals(updateDetail.getRefCode(), updatedDetail.getRefCode())) {
      hasChange = true;
      updatedDetail.setRefCode(updateDetail.getRefCode());
    }

    if (!hasChange) {
      throw new BusinessRuleViolationException(
          BR_01,
          "Track's detail has no changes: aggregateId=%s"
              .formatted(updateTrackDetailCommand.getId()));
    }

    final TrackDetailUpdatedEvent trackDetailUpdatedEvent =
        TrackDetailUpdatedEvent.builder().id(id).detail(updatedDetail).build();
    raiseEvent(trackDetailUpdatedEvent);
  }

  public void release() {
    if (Objects.nonNull(isReleased) && isReleased) {
      throw new BusinessRuleViolationException(
          TRACK_BR_01, "Track has already been released: aggregateId=%s".formatted(id));
    }
    final TrackReleasedEvent trackReleasedEvent =
        TrackReleasedEvent.builder()
            .id(id)
            .urn(urn)
            .detail(detail)
            .isPublic(isPublic)
            .isReleased(true)
            .tags(tags)
            .build();
    raiseEvent(trackReleasedEvent);
  }

  public void delete() {
    final Boolean isSoftDeleted = Optional.ofNullable(isReleased).orElse(false);
    final TrackDeletedEvent trackDeletedEvent =
        TrackDeletedEvent.builder().id(id).isSoftDeleted(isSoftDeleted).isActive(false).build();
    raiseEvent(trackDeletedEvent);
  }

  void apply(TrackCreatedEvent trackCreatedEvent) {
    this.id = trackCreatedEvent.getId();
    this.urn = trackCreatedEvent.getUrn();
    this.detail = trackCreatedEvent.getDetail();
    this.isPublic = trackCreatedEvent.getIsPublic();
    this.isActive = trackCreatedEvent.getIsActive();
    this.isReleased = trackCreatedEvent.getIsReleased();
    this.tags = trackCreatedEvent.getTags();
  }

  void apply(TrackDetailUpdatedEvent trackUpdatedEvent) {
    this.id = trackUpdatedEvent.getId();
    this.detail = trackUpdatedEvent.getDetail();
  }

  void apply(TrackReleasedEvent trackReleasedEvent) {
    this.id = trackReleasedEvent.getId();
    this.detail = trackReleasedEvent.getDetail();
    this.isReleased = trackReleasedEvent.getIsReleased();
  }

  void apply(TrackDeletedEvent trackDeletedEvent) {
    this.id = trackDeletedEvent.getId();
    this.isActive = trackDeletedEvent.getIsActive();
  }

  void apply(TrackVisibilitySetEvent trackVisibilityChangedEvent) {
    this.id = trackVisibilityChangedEvent.getId();
    this.isPublic = trackVisibilityChangedEvent.getIsPublic();
  }
}
