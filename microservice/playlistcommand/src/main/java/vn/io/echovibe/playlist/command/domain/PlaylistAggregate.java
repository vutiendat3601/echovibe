package vn.io.echovibe.playlist.command.domain;

import static vn.io.echovibe.playlist.common.constant.PlaylistConstant.PLAYLIST_URN_PREFIX;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.AggregateIllegalStateException;
import vn.io.echovibe.core.exception.NoneFieldChangedException;
import vn.io.echovibe.playlist.command.model.CreatePlaylistCommand;
import vn.io.echovibe.playlist.command.model.UpdatePlaylistCommand;
import vn.io.echovibe.playlist.common.event.PlaylistCreatedEvent;
import vn.io.echovibe.playlist.common.event.PlaylistDeletedEvent;
import vn.io.echovibe.playlist.common.event.PlaylistReleasedEvent;
import vn.io.echovibe.playlist.common.event.PlaylistUpdatedEvent;
import vn.io.echovibe.playlist.common.event.PlaylistVisibilityChangedEvent;

@Getter
@NoArgsConstructor
public class PlaylistAggregate extends AggregateRoot {
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

  public PlaylistAggregate(CreatePlaylistCommand createPlaylistCommand) {
    final String urn = PLAYLIST_URN_PREFIX + createPlaylistCommand.getId();
    final PlaylistCreatedEvent playlistCreatedEvent =
        PlaylistCreatedEvent.builder()
            .id(createPlaylistCommand.getId())
            .urn(urn)
            .name(createPlaylistCommand.getName())
            .description(createPlaylistCommand.getDescription())
            .isReleased(false)
            .isPublic(false)
            .isActive(true)
            .thumbnailUrl(createPlaylistCommand.getThumbnailUrl())
            .artistIds(createPlaylistCommand.getArtistIds())
            .refCode(createPlaylistCommand.getRefCode())
            .build();
    raiseEvent(playlistCreatedEvent);
  }

  public void setIsPublic(Boolean isPublic) {
    if (Objects.nonNull(isPublic) && isPublic.equals(this.isPublic)) {
      throw new NoneFieldChangedException(
          "Playlist's visiblity of hasn't changed: aggregateId=%s, isPublic=%s"
              .formatted(id, isPublic));
    }
    final Boolean isReleased = Optional.of(this.isReleased).orElse(false);
    if (!isReleased) {
      throw new AggregateIllegalStateException(
          "To make the track's visibility public, it is required to be released: aggregateId=%s, isPublic=%s, isReleased=%s"
              .formatted(id, isPublic, isReleased));
    }
    final PlaylistVisibilityChangedEvent playlistVisibilityChangedEvent =
        PlaylistVisibilityChangedEvent.builder().id(id).isPublic(isPublic).build();
    raiseEvent(playlistVisibilityChangedEvent);
  }

  public void update(UpdatePlaylistCommand updatePlaylistCommand) {
    final String name = updatePlaylistCommand.getName();
    final String thumbnailUrl = updatePlaylistCommand.getThumbnailUrl();
    boolean hasChange = false;
    final PlaylistUpdatedEvent playlistUpdatedEvent =
        PlaylistUpdatedEvent.builder()
            .id(id)
            .name(this.name)
            .thumbnailUrl(this.thumbnailUrl)
            .refCode(this.refCode)
            .build();
    // name
    if (!Objects.isNull(name) && !name.equals(playlistUpdatedEvent.getName())) {
      hasChange = true;
      playlistUpdatedEvent.setName(name);
    }
    // thumbnailUrl
    if (!Objects.isNull(thumbnailUrl)
        && !thumbnailUrl.equals(playlistUpdatedEvent.getThumbnailUrl())) {
      hasChange = true;
      playlistUpdatedEvent.setThumbnailUrl(thumbnailUrl);
    }
    // refCode
    if (!Objects.isNull(refCode) && !refCode.equals(playlistUpdatedEvent.getRefCode())) {
      hasChange = true;
      playlistUpdatedEvent.setRefCode(refCode);
    }
    if (!hasChange) {
      throw new NoneFieldChangedException();
    }
    raiseEvent(playlistUpdatedEvent);
  }

  public void release() {
    if (Objects.nonNull(isReleased) && isReleased) {
      throw new AggregateIllegalStateException(
          "Track has already been released: aggregateId=%s".formatted(id));
    }
    final PlaylistReleasedEvent trackReleasedEvent =
        PlaylistReleasedEvent.builder()
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
    final PlaylistDeletedEvent trackDeletedEvent =
        PlaylistDeletedEvent.builder().id(id).isSoftDeleted(isSoftDeleted).isActive(false).build();
    raiseEvent(trackDeletedEvent);
  }

  void apply(PlaylistCreatedEvent playlistCreatedEvent) {
    this.id = playlistCreatedEvent.getId();
    this.urn = playlistCreatedEvent.getUrn();
    this.name = playlistCreatedEvent.getName();
    this.isPublic = playlistCreatedEvent.getIsPublic();
    this.isActive = playlistCreatedEvent.getIsActive();
    this.isReleased = playlistCreatedEvent.getIsReleased();
    this.refCode = playlistCreatedEvent.getRefCode();
    this.tags = playlistCreatedEvent.getTags();
    this.refCode = playlistCreatedEvent.getRefCode();
  }

  void apply(PlaylistUpdatedEvent playlistUpdatedEvent) {
    this.id = playlistUpdatedEvent.getId();
    this.name = playlistUpdatedEvent.getName();
    this.thumbnailUrl = playlistUpdatedEvent.getThumbnailUrl();
    this.refCode = playlistUpdatedEvent.getRefCode();
  }

  void apply(PlaylistReleasedEvent playlistReleasedEvent) {
    this.id = playlistReleasedEvent.getId();
    this.isReleased = playlistReleasedEvent.getIsPublished();
  }

  void apply(PlaylistDeletedEvent playlistDeletedEvent) {
    this.id = playlistDeletedEvent.getId();
    this.isActive = playlistDeletedEvent.getIsActive();
  }

  void apply(PlaylistVisibilityChangedEvent playlistVisibilityChangedEvent) {
    this.id = playlistVisibilityChangedEvent.getId();
    this.isPublic = playlistVisibilityChangedEvent.getIsPublic();
  }
}
