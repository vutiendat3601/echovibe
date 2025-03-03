package vn.io.echovibe.artist.query.event;

import java.util.Optional;
import java.util.function.Consumer;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import vn.io.echovibe.artist.common.event.ArtistCreatedEvent;
import vn.io.echovibe.artist.common.event.ArtistDeletedEvent;
import vn.io.echovibe.artist.common.event.ArtistPublishedEvent;
import vn.io.echovibe.artist.common.event.ArtistUpdatedEvent;
import vn.io.echovibe.artist.common.event.ArtistVisibilityChangedEvent;
import vn.io.echovibe.artist.query.dao.ArtistDao;
import vn.io.echovibe.artist.query.entity.Artist;
import vn.io.echovibe.core.exception.ResourceNotFoundException;

@Configuration
@RequiredArgsConstructor
@Slf4j
public class ArtistEventConsumer {
  private final ArtistDao artistDao;

  @Bean
  Consumer<ArtistCreatedEvent> consumeArtistCreatedEvent() {
    return (artistCreatedEvent) -> {
      final String eventType = ArtistPublishedEvent.class.getSimpleName();
      final String aggregateId = artistCreatedEvent.getId();
      log.info(
          "Received event successfully: type=%s, aggregateId=%s".formatted(eventType, aggregateId));
      final Artist artist =
          Artist.builder()
              .aggregateId(artistCreatedEvent.getId())
              .name(artistCreatedEvent.getName())
              .urn(artistCreatedEvent.getUrn())
              .biography(artistCreatedEvent.getBiography())
              .description(artistCreatedEvent.getDescription())
              .isPublic(artistCreatedEvent.getIsPublic())
              .isActive(artistCreatedEvent.getIsActive())
              .isPublished(artistCreatedEvent.getIsPublished())
              .createdBy(artistCreatedEvent.getCreatedBy())
              .updatedBy(artistCreatedEvent.getCreatedBy())
              .build();
      artistDao.insert(artist);
      log.info(
          "Processed event successfully: type=%s, aggregateId=%s"
              .formatted(eventType, aggregateId));
    };
  }

  @Bean
  Consumer<ArtistUpdatedEvent> consumeArtistUpdatedEvent() {
    return (artistUpdatedEvent) -> {
      final String eventType = ArtistUpdatedEvent.class.getSimpleName();
      final String aggregateId = artistUpdatedEvent.getId();
      log.info(
          "Received event successfully: type=%s, aggregateId=%s".formatted(eventType, aggregateId));

      final Artist artist = findArtistAggregateByAggregateId(aggregateId);
      artist.setName(artistUpdatedEvent.getName());
      artist.setBiography(artistUpdatedEvent.getBiography());
      artist.setDescription(artistUpdatedEvent.getDescription());
      artist.setThumbnailUrl(artistUpdatedEvent.getThumbnailUrl());
      artist.setBackgroundUrl(artistUpdatedEvent.getBackgroundUrl());
      artistDao.update(artist);

      log.info(
          "Processed event successfully: type=%s, aggregateId=%s"
              .formatted(eventType, aggregateId));
    };
  }

  @Bean
  Consumer<ArtistDeletedEvent> consumeArtistDeletedEvent() {
    return (artistDeletedEvent) -> {
      final String eventType = ArtistDeletedEvent.class.getSimpleName();
      final String aggregateId = artistDeletedEvent.getId();
      log.info(
          "Received event successfully: type=%s, aggregateId=%s".formatted(eventType, aggregateId));

      final Artist artist = findArtistAggregateByAggregateId(aggregateId);
      final Boolean isSoftDeleted =
          Optional.ofNullable(artistDeletedEvent.getIsSoftDeleted()).orElse(true);
      if (isSoftDeleted) {
        artist.setIsActive(artistDeletedEvent.getIsActive());
        artistDao.update(artist);
      } else {
        artistDao.delete(aggregateId);
      }

      log.info(
          "Processed event successfully: type=%s, aggregateId=%s"
              .formatted(eventType, aggregateId));
    };
  }

  @Bean
  Consumer<ArtistPublishedEvent> consumeArtistPublishedEvent() {
    return (artistPublishedEvent) -> {
      final String eventType = ArtistPublishedEvent.class.getSimpleName();
      final String aggregateId = artistPublishedEvent.getId();
      log.info(
          "Received event successfully: type=%s, aggregateId=%s".formatted(eventType, aggregateId));

      final Artist artist = findArtistAggregateByAggregateId(aggregateId);
      final Boolean isPublished =
          Optional.ofNullable(artistPublishedEvent.getIsPublished()).orElse(true);
      artist.setIsPublished(isPublished);
      artistDao.update(artist);

      log.info(
          "Processed event successfully: type=%s, aggregateId=%s"
              .formatted(eventType, aggregateId));
    };
  }

  @Bean
  Consumer<ArtistVisibilityChangedEvent> consumeArtistVisibilityChangedEvent() {
    return (artistVisibilityChangedEvent) -> {
      final String eventType = ArtistVisibilityChangedEvent.class.getSimpleName();
      final String aggregateId = artistVisibilityChangedEvent.getId();
      log.info(
          "Received event successfully: type=%s, aggregateId=%s".formatted(eventType, aggregateId));

      final Artist artist = findArtistAggregateByAggregateId(aggregateId);
      final Boolean isPublic =
          Optional.ofNullable(artistVisibilityChangedEvent.getIsPublic()).orElse(false);
      artist.setIsActive(isPublic);
      artistDao.update(artist);

      log.info(
          "Processed event successfully: type=%s, aggregateId=%s"
              .formatted(eventType, aggregateId));
    };
  }

  private Artist findArtistAggregateByAggregateId(@NonNull String aggregateId) {
    return artistDao
        .selectArtistByAggregateIdAndIsActiveTrue(aggregateId)
        .orElseThrow(
            () ->
                new ResourceNotFoundException(
                    "Artist not found: aggregateId=%s".formatted(aggregateId)));
  }
}
