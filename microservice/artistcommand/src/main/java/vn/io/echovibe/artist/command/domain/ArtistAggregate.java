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
import java.util.stream.Collectors;
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
import vn.io.echovibe.core.util.StringUtils;

@NoArgsConstructor
@Getter
public class ArtistAggregate extends AggregateRoot {
  private String urn;

  private String refCode;

  private ArtistProfile profile;

  private Boolean isReleased;

  private Boolean isPublic;

  private Boolean isActive;

  private Boolean isVerified;

  private Integer revisionNumber = -1;

  private List<String> tags;

  public ArtistAggregate(CreateArtistCommand createArtistCommand) {
    final String urn = ARTIST_URN_PREFIX + createArtistCommand.getId();
    // Add name as initial tag.
    createArtistCommand.getTags().add(createArtistCommand.getProfile().getName());
    final Set<String> updatedTagsSet =
        new HashSet<>(createArtistCommand.getTags())
            .stream().map(StringUtils::removeAccent).collect(Collectors.toSet());
    final ArtistCreatedEvent artistCreatedEvent =
        ArtistCreatedEvent.builder()
            .id(createArtistCommand.getId())
            .urn(urn)
            .refCode(createArtistCommand.getRefCode())
            .profile(createArtistCommand.getProfile())
            .isPublic(createArtistCommand.getIsPublic())
            .isActive(true)
            .isVerified(false)
            .isReleased(false)
            .revisionNumber(-1)
            .tags(new ArrayList<>(updatedTagsSet))
            .build();
    raiseEvent(artistCreatedEvent);
  }

  public void update(UpdateArtistCommand updateArtistCommand) {
    final ArtistProfile updateProfile = updateArtistCommand.getProfile();
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
    if (!Objects.equals(artistUpdatedEvent.getRefCode(), updateArtistCommand.getRefCode())) {
      hasChange = true;
      artistUpdatedEvent.setRefCode(updateArtistCommand.getRefCode());
    }
    // isPublic
    if (!Objects.equals(artistUpdatedEvent.getIsPublic(), updateArtistCommand.getIsPublic())) {
      hasChange = true;
      artistUpdatedEvent.setIsPublic(updateArtistCommand.getIsPublic());
    }
    // tags
    if (Objects.nonNull(updateArtistCommand.getTags())) {
      final Set<String> updatedTagsSet =
          new HashSet<>(
              Optional.ofNullable(artistUpdatedEvent.getTags()).orElse(new ArrayList<>()));
      final Set<String> updateTagsSet =
          new HashSet<>(updateArtistCommand.getTags())
              .stream().map(StringUtils::removeAccent).collect(Collectors.toSet());
      if (!updatedTagsSet.containsAll(updateTagsSet)) {
        hasChange = true;
        artistUpdatedEvent.setTags(new ArrayList<>(updateTagsSet));
      }
    }
    if (!hasChange) {
      throw new BusinessRuleViolationException(
          BR_01, "Artist has no changes: aggregateId=%s".formatted(updateArtistCommand.getId()));
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
            .id(id)
            .urn(urn)
            .profile(profile)
            .isReleased(true)
            .revisionNumber(++revisionNumber)
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

  public void setVerified(Boolean isVerified) {
    if (Objects.equals(this.isVerified, isVerified)) {
      throw new BusinessRuleViolationException(
          BR_01,
          "Artist's verification has no changes: aggregateId=%s, isVerified=%s"
              .formatted(id, isVerified));
    }
    final ArtistVerificationSetEvent artistVerificationSetEvent =
        ArtistVerificationSetEvent.builder()
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
    this.revisionNumber = artistCreatedEvent.getRevisionNumber();
    this.tags = artistCreatedEvent.getTags();
  }

  void apply(ArtistUpdatedEvent artistUpdatedEvent) {
    this.id = artistUpdatedEvent.getId();
    this.refCode = artistUpdatedEvent.getRefCode();
    this.profile = artistUpdatedEvent.getProfile();
    this.isPublic = artistUpdatedEvent.getIsPublic();
    this.isReleased = artistUpdatedEvent.getIsReleased();
    this.tags = artistUpdatedEvent.getTags();
  }

  void apply(ArtistReleasedEvent artistReleasedEvent) {
    this.id = artistReleasedEvent.getId();
    this.urn = artistReleasedEvent.getUrn();
    this.profile = artistReleasedEvent.getProfile();
    this.isVerified = artistReleasedEvent.getIsVerifed();
    this.refCode = artistReleasedEvent.getRefCode();
    this.revisionNumber = artistReleasedEvent.getRevisionNumber();
    this.isReleased = artistReleasedEvent.getIsReleased();
    this.isPublic = artistReleasedEvent.getIsPublic();
    this.tags = artistReleasedEvent.getTags();
  }

  void apply(ArtistDeletedEvent artistDeletedEvent) {
    this.id = artistDeletedEvent.getId();
    this.isActive = artistDeletedEvent.getIsActive();
  }

  void apply(ArtistVerificationSetEvent artistVerificationSetEvent) {
    this.id = artistVerificationSetEvent.getId();
    this.isReleased = artistVerificationSetEvent.getIsReleased();
  }
}
