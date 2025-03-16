package vn.io.echovibe.artist.command.domain;

import static vn.io.echovibe.artist.common.constant.ArtistBussinessRuleConstant.ARTIST_BR_01;
import static vn.io.echovibe.artist.common.constant.ArtistConstant.ARTIST_URN_PREFIX;
import static vn.io.echovibe.core.constant.BusinessRuleConstant.BR_01;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistProfileCommand;
import vn.io.echovibe.artist.common.event.ArtistCreatedEvent;
import vn.io.echovibe.artist.common.event.ArtistDeletedEvent;
import vn.io.echovibe.artist.common.event.ArtistProfileUpdatedEvent;
import vn.io.echovibe.artist.common.event.ArtistReleasedEvent;
import vn.io.echovibe.artist.common.event.ArtistVisibilitySetEvent;
import vn.io.echovibe.artist.common.model.ArtistProfile;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.BusinessRuleViolationException;

@Getter
@NoArgsConstructor
public class ArtistAggregate extends AggregateRoot {
  private String urn;

  private ArtistProfile profile;

  private Boolean isReleased;

  private Boolean isPublic;

  private Boolean isActive;

  private List<String> tags;

  public ArtistAggregate(CreateArtistCommand createArtistCommand) {
    final String urn = ARTIST_URN_PREFIX + createArtistCommand.getId();
    final ArtistCreatedEvent artistCreatedEvent =
        ArtistCreatedEvent.builder()
            .id(createArtistCommand.getId())
            .urn(urn)
            .profile(createArtistCommand.getProfile())
            .isReleased(false)
            .isPublic(false)
            .isActive(true)
            .build();
    raiseEvent(artistCreatedEvent);
  }

  public void update(UpdateArtistProfileCommand updateArtistProfileCommand) {
    final ArtistProfile updateProfile = updateArtistProfileCommand.getProfile();

    boolean hasChange = false;
    final ArtistProfile updatedProfile =
        ArtistProfile.builder()
            .name(this.profile.getName())
            .biography(this.profile.getBiography())
            .description(this.profile.getDescription())
            .thumbnailFileKey(this.profile.getThumbnailFileKey())
            .thumbnailUrl(this.profile.getThumbnailUrl())
            .backgroundFileKey(this.profile.getBackgroundFileKey())
            .backgroundUrl(this.profile.getBackgroundUrl())
            .build();

    // name
    if (!Objects.equals(updateProfile.getName(), updatedProfile.getName())) {
      hasChange = true;
      updatedProfile.setName(updateProfile.getName());
    }
    // biography
    if (!Objects.equals(updateProfile.getBiography(), updatedProfile.getBiography())) {
      hasChange = true;
      updatedProfile.setBiography(updateProfile.getBiography());
    }
    // description
    if (!Objects.equals(updateProfile.getDescription(), updatedProfile.getDescription())) {
      hasChange = true;
      updatedProfile.setDescription(updateProfile.getDescription());
    }
    // thumbnailUrl
    if (!Objects.equals(updateProfile.getThumbnailUrl(), updatedProfile.getThumbnailUrl())) {
      hasChange = true;
      updatedProfile.setThumbnailUrl(updateProfile.getThumbnailUrl());
    }
    // backgroundUrl
    if (!Objects.equals(updateProfile.getBackgroundUrl(), updatedProfile.getBackgroundUrl())) {
      hasChange = true;
      updatedProfile.setBackgroundUrl(updateProfile.getBackgroundUrl());
    }
    if (!hasChange) {
      throw new BusinessRuleViolationException(
          BR_01,
          "Artist's profile has no changes: aggregateId=%s"
              .formatted(updateArtistProfileCommand.getId()));
    }
    final ArtistProfileUpdatedEvent artistProfileUpdatedEvent =
        ArtistProfileUpdatedEvent.builder().id(id).profile(updatedProfile).build();
    raiseEvent(artistProfileUpdatedEvent);
  }

  public void release() {
    if (Objects.nonNull(isReleased) && isReleased) {
      throw new BusinessRuleViolationException(
          ARTIST_BR_01, "Artist has already been released: aggregateId=%s".formatted(id));
    }
    final ArtistReleasedEvent artistReleasedEvent =
        ArtistReleasedEvent.builder()
            .id(id)
            .urn(urn)
            .profile(profile)
            .isReleased(true)
            .isPublic(isPublic)
            .tags(tags)
            .build();
    raiseEvent(artistReleasedEvent);
  }

  public void delete() {
    final Boolean isSoftDeleted = Optional.ofNullable(isReleased).orElse(false);
    final ArtistDeletedEvent artistDeletedEvent =
        ArtistDeletedEvent.builder().id(id).isSoftDeleted(isSoftDeleted).isActive(false).build();
    raiseEvent(artistDeletedEvent);
  }

  public void setIsPublic(Boolean isPublic) {
    if (Objects.nonNull(isPublic) && isPublic.equals(this.isPublic)) {
      throw new BusinessRuleViolationException(
          BR_01,
          "Artist's visiblity has no changes: aggregateId=%s, isPublic=%s".formatted(id, isPublic));
    }
    final ArtistVisibilitySetEvent artistVisibilityChangedEvent =
        ArtistVisibilitySetEvent.builder().id(id).isPublic(isPublic).build();
    raiseEvent(artistVisibilityChangedEvent);
  }

  // ### ArtistAggregate event apply functions #################################

  void apply(ArtistCreatedEvent artistCreatedEvent) {
    this.id = artistCreatedEvent.getId();
    this.urn = artistCreatedEvent.getUrn();
    this.profile = artistCreatedEvent.getProfile();
    this.isPublic = artistCreatedEvent.getIsPublic();
    this.isActive = artistCreatedEvent.getIsActive();
    this.isReleased = artistCreatedEvent.getIsReleased();
    this.tags = artistCreatedEvent.getTags();
  }

  void apply(ArtistProfileUpdatedEvent artistProfileUpdatedEvent) {
    this.id = artistProfileUpdatedEvent.getId();
    this.profile = artistProfileUpdatedEvent.getProfile();
  }

  void apply(ArtistReleasedEvent artistReleasedEvent) {
    this.id = artistReleasedEvent.getId();
    this.urn = artistReleasedEvent.getUrn();
    this.profile = artistReleasedEvent.getProfile();
    this.isReleased = artistReleasedEvent.getIsReleased();
    this.isPublic = artistReleasedEvent.getIsPublic();
  }

  void apply(ArtistDeletedEvent artistDeletedEvent) {
    this.id = artistDeletedEvent.getId();
    this.isActive = artistDeletedEvent.getIsActive();
  }

  void apply(ArtistVisibilitySetEvent artistVisibilityChangedEvent) {
    this.id = artistVisibilityChangedEvent.getId();
    this.isPublic = artistVisibilityChangedEvent.getIsPublic();
  }
}
