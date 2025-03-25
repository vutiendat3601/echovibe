package vn.io.echovibe.artist.command.domain;

import static vn.io.echovibe.artist.common.constant.ArtistBussinessRuleConstant.ARTIST_BR_01;
import static vn.io.echovibe.artist.common.constant.ArtistConstant.ARTIST_URN_PREFIX;
import static vn.io.echovibe.core.constant.BusinessRuleConstant.BR_01;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import lombok.Getter;
import lombok.NoArgsConstructor;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;
import vn.io.echovibe.artist.common.event.ArtistCreatedEvent;
import vn.io.echovibe.artist.common.event.ArtistDeletedEvent;
import vn.io.echovibe.artist.common.event.ArtistReleasedEvent;
import vn.io.echovibe.artist.common.event.ArtistUpdatedEvent;
import vn.io.echovibe.artist.common.event.ArtistVerificationSetEvent;
import vn.io.echovibe.artist.common.model.ArtistProfile;
import vn.io.echovibe.core.domain.AggregateRoot;
import vn.io.echovibe.core.exception.BusinessRuleViolationException;

@Getter
@NoArgsConstructor
public class ArtistAggregate extends AggregateRoot {
  private String urn;

  private String refCode;

  private ArtistProfile profile;

  private Boolean isReleased;

  private Boolean isPublic;

  private Boolean isActive;

  private Boolean isVerified;

  private Integer releasedVersion = -1;

  private List<String> tags;

  public ArtistAggregate(CreateArtistCommand createArtistCommand) {
    final String urn = ARTIST_URN_PREFIX + createArtistCommand.getId();
    final ArtistCreatedEvent artistCreatedEvent =
        ArtistCreatedEvent.builder()
            .id(createArtistCommand.getId())
            .type(ArtistCreatedEvent.class.getSimpleName())
            .urn(urn)
            .refCode(createArtistCommand.getRefCode())
            .profile(createArtistCommand.getProfile())
            .isReleased(false)
            .releasedVersion(-1)
            .isPublic(false)
            .isActive(true)
            .isVerified(createArtistCommand.getIsVerified())
            .tags(createArtistCommand.getTags())
            .build();
    raiseEvent(artistCreatedEvent);
  }

  public void update(UpdateArtistCommand updateArtistProfileCommand) {
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
    final ArtistUpdatedEvent artistUpdatedEvent =
        ArtistUpdatedEvent.builder()
            .id(id)
            .refCode(refCode)
            .isReleased(false)
            .isPublic(isPublic)
            .tags(tags)
            .profile(updatedProfile)
            .build();

    // name
    if (!Objects.equals(updateProfile.getName(), updatedProfile.getName())) {
      hasChange = true;
      updatedProfile.setName(updateProfile.getName());
    }
    // description
    if (!Objects.equals(updateProfile.getDescription(), updatedProfile.getDescription())) {
      hasChange = true;
      updatedProfile.setDescription(updateProfile.getDescription());
    }
    // biography
    if (!Objects.equals(updateProfile.getBiography(), updatedProfile.getBiography())) {
      hasChange = true;
      updatedProfile.setBiography(updateProfile.getBiography());
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
    // refCode
    if (!Objects.equals(artistUpdatedEvent.getRefCode(), updateArtistProfileCommand.getRefCode())) {
      hasChange = true;
      artistUpdatedEvent.setRefCode(updateArtistProfileCommand.getRefCode());
    }
    // isPublic
    if (!Objects.equals(
        artistUpdatedEvent.getIsPublic(), updateArtistProfileCommand.getIsPublic())) {
      hasChange = true;
      artistUpdatedEvent.setIsPublic(updateArtistProfileCommand.getIsPublic());
    }
    // tags
    if (Objects.nonNull(updateArtistProfileCommand.getTags())) {
      final Set<String> updatedTagsSet =
          new HashSet<>(
              Optional.ofNullable(artistUpdatedEvent.getTags()).orElse(new ArrayList<>()));
      final Set<String> updateTagsSet = new HashSet<>(updateArtistProfileCommand.getTags());
      if (!updatedTagsSet.containsAll(updateTagsSet)) {
        hasChange = true;
        artistUpdatedEvent.setTags(new ArrayList<>(updateTagsSet));
      }
    }
    if (!hasChange) {
      throw new BusinessRuleViolationException(
          BR_01,
          "Artist's profile has no changes: aggregateId=%s"
              .formatted(updateArtistProfileCommand.getId()));
    }
    raiseEvent(artistUpdatedEvent);
  }

  public void release() {
    if (Objects.nonNull(isReleased) && isReleased) {
      throw new BusinessRuleViolationException(
          ARTIST_BR_01, "Artist has already been released: aggregateId=%s".formatted(id));
    }
    final ArtistReleasedEvent artistReleasedEvent =
        ArtistReleasedEvent.builder()
            .type(ArtistReleasedEvent.class.getSimpleName())
            .id(id)
            .urn(urn)
            .profile(profile)
            .isReleased(true)
            .releasedVersion(++releasedVersion)
            .isPublic(isPublic)
            .tags(tags)
            .build();
    raiseEvent(artistReleasedEvent);
  }

  public void delete() {
    final Boolean isSoftDeleted = Optional.ofNullable(isReleased).orElse(false);
    final ArtistDeletedEvent artistDeletedEvent =
        ArtistDeletedEvent.builder()
            .type(ArtistDeletedEvent.class.getSimpleName())
            .id(id)
            .isSoftDeleted(isSoftDeleted)
            .isActive(false)
            .build();
    raiseEvent(artistDeletedEvent);
  }

  public void setVerified(Boolean isVerified) {
    if (Objects.equals(this.isVerified, isVerified)) {
      throw new BusinessRuleViolationException(
          BR_01,
          "Artist's verification has no changes: aggregateId=%s, isVerified=%s"
              .formatted(id, isVerified));
    }
    final ArtistVerificationSetEvent artistVerificationSetEvent =
        ArtistVerificationSetEvent.builder()
            .type(ArtistVerificationSetEvent.class.getSimpleName())
            .id(id)
            .isVerified(isVerified)
            .isReleased(false)
            .build();
    raiseEvent(artistVerificationSetEvent);
  }

  // ### ArtistAggregate event apply functions #################################

  void apply(ArtistCreatedEvent artistCreatedEvent) {
    this.id = artistCreatedEvent.getId();
    this.urn = artistCreatedEvent.getUrn();
    this.profile = artistCreatedEvent.getProfile();
    this.isPublic = artistCreatedEvent.getIsPublic();
    this.isActive = artistCreatedEvent.getIsActive();
    this.isVerified = artistCreatedEvent.getIsVerified();
    this.isReleased = artistCreatedEvent.getIsReleased();
    this.tags = artistCreatedEvent.getTags();
  }

  void apply(ArtistUpdatedEvent artistProfileUpdatedEvent) {
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

  void apply(ArtistVerificationSetEvent artistVisibilityChangedEvent) {
    this.id = artistVisibilityChangedEvent.getId();
    this.isPublic = artistVisibilityChangedEvent.getIsVerified();
  }
}
