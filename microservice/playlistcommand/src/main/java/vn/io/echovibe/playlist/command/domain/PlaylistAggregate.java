package vn.io.echovibe.playlist.command.domain;

import static vn.io.echovibe.core.constant.BusinessRuleConstant.BR_01;
import static vn.io.echovibe.playlist.common.constant.PlaylistBusinessRuleConstant.PLAYLIST_BR_01;
import static vn.io.echovibe.playlist.common.constant.PlaylistConstant.PLAYLIST_URN_PREFIX;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.BusinessRuleViolationException;
import vn.io.echovibe.playlist.command.model.CreatePlaylistCommand;
import vn.io.echovibe.playlist.command.model.UpdatePlaylistDetailCommand;
import vn.io.echovibe.playlist.common.event.PlaylistCreatedEvent;
import vn.io.echovibe.playlist.common.event.PlaylistDeletedEvent;
import vn.io.echovibe.playlist.common.event.PlaylistDetailUpdatedEvent;
import vn.io.echovibe.playlist.common.event.PlaylistReleasedEvent;
import vn.io.echovibe.playlist.common.event.PlaylistVisibilitySetEvent;
import vn.io.echovibe.playlist.common.model.PlaylistDetail;

@Getter
@NoArgsConstructor
public class PlaylistAggregate extends AggregateRoot {
  private String urn;

  private PlaylistDetail detail;

  private Boolean isReleased;

  private Boolean isPublic;

  private Boolean isActive;

  private List<String> tags;

  public PlaylistAggregate(CreatePlaylistCommand createPlaylistCommand) {
    final String urn = PLAYLIST_URN_PREFIX + createPlaylistCommand.getId();
    final PlaylistCreatedEvent playlistCreatedEvent =
        PlaylistCreatedEvent.builder()
            .id(createPlaylistCommand.getId())
            .urn(urn)
            .detail(createPlaylistCommand.getDetail())
            .isReleased(false)
            .isPublic(false)
            .isActive(true)
            .build();
    raiseEvent(playlistCreatedEvent);
  }

  public void setIsPublic(Boolean isPublic) {
    if (Objects.nonNull(isPublic) && isPublic.equals(this.isPublic)) {
      throw new BusinessRuleViolationException(
          BR_01,
          "Playlist's visiblity has no changes: aggregateId=%s, isPublic=%s"
              .formatted(id, isPublic));
    }
    final PlaylistVisibilitySetEvent playlistVisibilityChangedEvent =
        PlaylistVisibilitySetEvent.builder().id(id).isPublic(isPublic).build();
    raiseEvent(playlistVisibilityChangedEvent);
  }

  public void update(UpdatePlaylistDetailCommand updatePlaylistDetailCommand) {
    final PlaylistDetail updateDetail = updatePlaylistDetailCommand.getDetail();

    boolean hasChange = false;
    final PlaylistDetail updatedDetail =
        PlaylistDetail.builder()
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
      updateDetail.setThumbnailUrl(updateDetail.getThumbnailUrl());
    }
    // refCode
    if (!Objects.equals(updateDetail.getRefCode(), updatedDetail.getRefCode())) {
      hasChange = true;
      updateDetail.setRefCode(updateDetail.getRefCode());
    }

    if (!hasChange) {
      throw new BusinessRuleViolationException(
          BR_01,
          "Playlist's detail has no changes: aggregateId=%s"
              .formatted(updatePlaylistDetailCommand.getId()));
    }

    final PlaylistDetailUpdatedEvent playlistDetailUpdatedEvent =
        PlaylistDetailUpdatedEvent.builder().id(id).detail(updatedDetail).build();
    raiseEvent(playlistDetailUpdatedEvent);
  }

  public void release() {
    if (Objects.nonNull(isReleased) && isReleased) {
      throw new BusinessRuleViolationException(
          PLAYLIST_BR_01, "Playlist has already been released: aggregateId=%s".formatted(id));
    }
    final PlaylistReleasedEvent trackReleasedEvent =
        PlaylistReleasedEvent.builder()
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
    final PlaylistDeletedEvent trackDeletedEvent =
        PlaylistDeletedEvent.builder().id(id).isSoftDeleted(isSoftDeleted).isActive(false).build();
    raiseEvent(trackDeletedEvent);
  }

  // ### PlaylistAggregate event apply functions ###############################

  void apply(PlaylistCreatedEvent playlistCreatedEvent) {
    this.id = playlistCreatedEvent.getId();
    this.urn = playlistCreatedEvent.getUrn();
    this.detail = playlistCreatedEvent.getDetail();
    this.isPublic = playlistCreatedEvent.getIsPublic();
    this.isActive = playlistCreatedEvent.getIsActive();
    this.isReleased = playlistCreatedEvent.getIsReleased();
    this.tags = playlistCreatedEvent.getTags();
  }

  void apply(PlaylistDetailUpdatedEvent playlistDetailUpdatedEvent) {
    this.id = playlistDetailUpdatedEvent.getId();
    this.detail = playlistDetailUpdatedEvent.getDetail();
  }

  void apply(PlaylistReleasedEvent playlistReleasedEvent) {
    this.id = playlistReleasedEvent.getId();
    this.detail = playlistReleasedEvent.getDetail();
    this.isReleased = playlistReleasedEvent.getIsReleased();
  }

  void apply(PlaylistDeletedEvent playlistDeletedEvent) {
    this.id = playlistDeletedEvent.getId();
    this.isActive = playlistDeletedEvent.getIsActive();
  }

  void apply(PlaylistVisibilitySetEvent playlistVisibilityChangedEvent) {
    this.id = playlistVisibilityChangedEvent.getId();
    this.isPublic = playlistVisibilityChangedEvent.getIsPublic();
  }
}
