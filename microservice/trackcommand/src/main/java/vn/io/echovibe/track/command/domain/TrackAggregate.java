package vn.io.echovibe.track.command.domain;

import static vn.io.echovibe.core.constant.BusinessRuleConstant.BR_01;
import static vn.io.echovibe.track.common.constant.TrackBusinessRuleConstant.TRACK_BR_01;
import static vn.io.echovibe.track.common.constant.TrackBusinessRuleConstant.TRACK_BR_03;
import static vn.io.echovibe.track.common.constant.TrackConstant.TRACK_URN_PREFIX;

import java.util.List;
import java.util.Objects;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.BusinessRuleViolationException;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;
import vn.io.echovibe.track.common.event.TrackCreatedEvent;
import vn.io.echovibe.track.common.event.TrackDeletedEvent;
import vn.io.echovibe.track.common.event.TrackReleasedEvent;
import vn.io.echovibe.track.common.event.TrackUpdatedEvent;
import vn.io.echovibe.track.common.model.Tag;
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

  private List<Tag> tags;

  private Integer revisionNumber = -1;

  private String refCode;

  public TrackAggregate(CreateTrackCommand createTrackCommand) {
    final String urn = TRACK_URN_PREFIX + createTrackCommand.getId();
    final TrackCreatedEvent trackCreatedEvent =
        TrackCreatedEvent.builder()
            .id(createTrackCommand.getId())
            .urn(urn)
            .revisionNumber(-1)
            .tags(createTrackCommand.getTags())
            .detail(createTrackCommand.getDetail())
            .artistIds(createTrackCommand.getArtistIds())
            .isReleased(false)
            .isPublic(createTrackCommand.getIsPublic())
            .refCode(createTrackCommand.getRefCode())
            .build();
    raiseEvent(trackCreatedEvent);
  }

  public void update(UpdateTrackCommand updateTrackCommand) {
    final TrackDetail updateDetail = updateTrackCommand.getDetail();
    boolean hasChange = false;

    final TrackDetail updatedDetail =
        TrackDetail.builder()
            .name(this.detail.getName())
            .description(this.detail.getDescription())
            .thumbnailFileKey(this.detail.getThumbnailFileKey())
            .thumbnailUrl(this.detail.getThumbnailUrl())
            .build();
    final TrackUpdatedEvent trackUpdatedEvent =
        TrackUpdatedEvent.builder()
            .id(updateTrackCommand.getId())
            .detail(updatedDetail)
            .refCode(refCode)
            .isPublic(isPublic)
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
    if (!Objects.equals(updateTrackCommand.getRefCode(), trackUpdatedEvent.getRefCode())) {
      if (this.revisionNumber > -1) {
        throw new BusinessRuleViolationException(
            TRACK_BR_03,
            "Can't update Track's refCode once it has been released at least once: aggregateId=%s"
                .formatted(updateTrackCommand.getId()));
      }
      hasChange = true;
      trackUpdatedEvent.setRefCode(updateTrackCommand.getRefCode());
    }

    if (!hasChange) {
      throw new BusinessRuleViolationException(
          BR_01, "Track has no changes: aggregateId=%s".formatted(updateTrackCommand.getId()));
    }

    final TrackUpdatedEvent trackDetailUpdatedEvent =
        TrackUpdatedEvent.builder().id(id).detail(updatedDetail).build();
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
    final Boolean isSoftDeleted = revisionNumber > -1;
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
    this.artistIds = trackCreatedEvent.getArtistIds();
    this.refCode = trackCreatedEvent.getRefCode();
    this.revisionNumber = trackCreatedEvent.getRevisionNumber();
  }

  void apply(TrackUpdatedEvent trackUpdatedEvent) {
    this.id = trackUpdatedEvent.getId();
    this.isPublic = trackUpdatedEvent.getIsPublic();
    this.refCode = trackUpdatedEvent.getRefCode();
    this.detail = trackUpdatedEvent.getDetail();
    this.tags = trackUpdatedEvent.getTags();
  }

  void apply(TrackReleasedEvent trackReleasedEvent) {
    this.id = trackReleasedEvent.getId();
    this.detail = trackReleasedEvent.getDetail();
    this.isReleased = trackReleasedEvent.getIsReleased();
    this.isPublic = trackReleasedEvent.getIsPublic();
    this.tags = trackReleasedEvent.getTags();
    this.revisionNumber = trackReleasedEvent.getRevisionNumber();
  }

  void apply(TrackDeletedEvent trackDeletedEvent) {
    this.id = trackDeletedEvent.getId();
    this.isActive = trackDeletedEvent.getIsActive();
  }
}
