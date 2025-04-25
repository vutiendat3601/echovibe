package vn.io.echovibe.track.command.domain;

import static vn.io.echovibe.core.constant.BusinessRuleConstant.BR_01;
import static vn.io.echovibe.track.common.constant.TrackBusinessRuleConstant.TRACK_BR_01;
import static vn.io.echovibe.track.common.constant.TrackBusinessRuleConstant.TRACK_BR_03;
import static vn.io.echovibe.track.common.constant.TrackBusinessRuleConstant.TRACK_BR_04;
import static vn.io.echovibe.track.common.constant.TrackConstant.TRACK_URN_PREFIX;

import java.util.List;
import java.util.Objects;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.BusinessRuleViolationException;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.MapTrackAudioCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;
import vn.io.echovibe.track.common.event.TrackAudioMappedEvent;
import vn.io.echovibe.track.common.event.TrackCreatedEvent;
import vn.io.echovibe.track.common.event.TrackDeletedEvent;
import vn.io.echovibe.track.common.event.TrackReleasedEvent;
import vn.io.echovibe.track.common.event.TrackUpdatedEvent;
import vn.io.echovibe.track.common.model.Tag;
import vn.io.echovibe.track.common.model.TrackArtist;
import vn.io.echovibe.track.common.model.TrackAudio;
import vn.io.echovibe.track.common.model.TrackDetail;

@Getter
@NoArgsConstructor
public class TrackAggregate extends AggregateRoot {
  private String urn;

  private TrackDetail detail;

  private Boolean isReleased;

  private Boolean isPublic;

  private Boolean isActive;

  private List<TrackArtist> trackArtists;

  private List<Tag> tags;

  private Integer revisionNumber = -1;

  private String refCode;

  private TrackAudio trackAudio;

  public TrackAggregate(CreateTrackCommand createTrackCommand) {
    final String urn = TRACK_URN_PREFIX + createTrackCommand.getId();
    final TrackCreatedEvent trackCreatedEvent =
        TrackCreatedEvent.builder()
            .id(createTrackCommand.getId())
            .urn(urn)
            .revisionNumber(-1)
            .tags(createTrackCommand.getTags())
            .detail(createTrackCommand.getDetail())
            .trackArtists(createTrackCommand.getTrackArtists())
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
            .tags(tags)
            .isReleased(false)
            .build();

    // name
    if (!Objects.equals(updateDetail.getName(), updatedDetail.getName())) {
      hasChange = true;
      updatedDetail.setName(updateDetail.getName());
    }
    // description
    if (!Objects.equals(updateDetail.getDescription(), updatedDetail.getDescription())) {
      hasChange = true;
      updatedDetail.setDescription(updateDetail.getDescription());
    }

    // thumbnailUrl
    if (!Objects.equals(updateDetail.getThumbnailUrl(), updatedDetail.getThumbnailUrl())) {
      hasChange = true;
      updatedDetail.setThumbnailUrl(updateDetail.getThumbnailUrl());
    }

    // officialReleasedDate
    if (!Objects.equals(
        updateDetail.getOfficialReleasedDate(), updatedDetail.getOfficialReleasedDate())) {
      hasChange = true;
      updatedDetail.setOfficialReleasedDate(updateDetail.getOfficialReleasedDate());
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

    // isPublic
    if (!Objects.equals(updateTrackCommand.getIsPublic(), trackUpdatedEvent.getIsPublic())) {
      hasChange = true;
      trackUpdatedEvent.setIsPublic(updateTrackCommand.getIsPublic());
    }

    // tags
    if (!Objects.equals(updateTrackCommand.getTags(), trackUpdatedEvent.getTags())) {
      hasChange = true;
      trackUpdatedEvent.setTags(updateTrackCommand.getTags());
    }

    // trackArtists
    if (!Objects.equals(
        updateTrackCommand.getTrackArtists(), trackUpdatedEvent.getTrackArtists())) {
      hasChange = true;
      trackUpdatedEvent.setTrackArtists(updateTrackCommand.getTrackArtists());
    }

    if (!hasChange) {
      throw new BusinessRuleViolationException(
          BR_01, "Track has no changes: aggregateId=%s".formatted(updateTrackCommand.getId()));
    }

    raiseEvent(trackUpdatedEvent);
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
            .revisionNumber(++revisionNumber)
            .refCode(refCode)
            .trackAudio(trackAudio)
            .trackArtists(trackArtists)
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

  public void mapTrackAudio(MapTrackAudioCommand mapTrackAudioCommand) {
    final TrackAudio trackAudio = mapTrackAudioCommand.getTrackAudio();
    if (Objects.isNull(trackAudio.getFileKey()) && Objects.isNull(trackAudio.getFileM3u8Url())) {
      throw new BusinessRuleViolationException(
          TRACK_BR_04, "Track Audio must inclues at least audioFileKey or fileM3u8Url");
    }
    final TrackAudioMappedEvent trackAudioMappedEvent =
        TrackAudioMappedEvent.builder()
            .id(this.id)
            .trackAudio(trackAudio)
            .isReleased(false)
            .build();
    raiseEvent(trackAudioMappedEvent);
  }

  // ### TrackAggregate event apply functions #################################

  void apply(TrackCreatedEvent trackCreatedEvent) {
    this.id = trackCreatedEvent.getId();
    this.urn = trackCreatedEvent.getUrn();
    this.detail = trackCreatedEvent.getDetail();
    this.isPublic = trackCreatedEvent.getIsPublic();
    this.isActive = trackCreatedEvent.getIsActive();
    this.isReleased = trackCreatedEvent.getIsReleased();
    this.tags = trackCreatedEvent.getTags();
    this.trackArtists = trackCreatedEvent.getTrackArtists();
    this.refCode = trackCreatedEvent.getRefCode();
    this.revisionNumber = trackCreatedEvent.getRevisionNumber();
  }

  void apply(TrackUpdatedEvent trackUpdatedEvent) {
    this.id = trackUpdatedEvent.getId();
    this.isPublic = trackUpdatedEvent.getIsPublic();
    this.refCode = trackUpdatedEvent.getRefCode();
    this.detail = trackUpdatedEvent.getDetail();
    this.isReleased = trackUpdatedEvent.getIsReleased();
    this.tags = trackUpdatedEvent.getTags();
    this.trackArtists = trackUpdatedEvent.getTrackArtists();
  }

  void apply(TrackReleasedEvent trackReleasedEvent) {
    this.id = trackReleasedEvent.getId();
    this.detail = trackReleasedEvent.getDetail();
    this.isReleased = trackReleasedEvent.getIsReleased();
    this.isPublic = trackReleasedEvent.getIsPublic();
    this.tags = trackReleasedEvent.getTags();
    this.trackArtists = trackReleasedEvent.getTrackArtists();
    this.refCode = trackReleasedEvent.getRefCode();
    this.trackAudio = trackReleasedEvent.getTrackAudio();
    this.revisionNumber = trackReleasedEvent.getRevisionNumber();
  }

  void apply(TrackDeletedEvent trackDeletedEvent) {
    this.id = trackDeletedEvent.getId();
    this.isActive = trackDeletedEvent.getIsActive();
  }

  void apply(TrackAudioMappedEvent trackAudioMappedEvent) {
    this.id = trackAudioMappedEvent.getId();
    this.trackAudio = trackAudioMappedEvent.getTrackAudio();
    this.isReleased = trackAudioMappedEvent.getIsReleased();
  }
}
