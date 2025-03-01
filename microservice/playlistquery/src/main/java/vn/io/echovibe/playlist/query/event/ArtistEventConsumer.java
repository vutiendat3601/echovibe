package vn.io.echovibe.artist.query.event;

import java.util.function.Consumer;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import vn.io.echovibe.artist.common.event.ArtistCreatedEvent;
import vn.io.echovibe.artist.common.event.ArtistPublishedEvent;
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
      final String aggregateId = artistCreatedEvent.getId();
      log.info(
          "Received event successfully: type=ArtistCreatedEvent, aggregateId=%s"
              .formatted(aggregateId));
      final Artist artist =
          Artist.builder()
              .aggregateId(artistCreatedEvent.getId())
              .urn(artistCreatedEvent.getUrn())
              .name(artistCreatedEvent.getName())
              .description(artistCreatedEvent.getDescription())
              .isPublic(artistCreatedEvent.getIsPublic())
              .isActive(artistCreatedEvent.getIsActive())
              .isPublished(artistCreatedEvent.getIsPublished())
              .createdBy(artistCreatedEvent.getCreatedBy())
              .updatedBy(artistCreatedEvent.getCreatedBy())
              .build();
      artistDao.insert(artist);
      log.info(
          "Processed event successfully: type=ArtistCreatedEvent, aggregateId=%s"
              .formatted(aggregateId));
    };
  }

  @Bean
  Consumer<ArtistPublishedEvent> consumeArtistPublishedEvent() {
    return (artistPublishedEvent) -> {
      final String aggregateId = artistPublishedEvent.getId();
      log.info(
          "Received event successfully: type=ArtistPublishedEvent, aggregateId=%s"
              .formatted(aggregateId));
      final Artist artist =
          artistDao
              .selectArtistByAggregateIdAndIsActiveTrue(aggregateId)
              .orElseThrow(
                  () ->
                      new ResourceNotFoundException(
                          "Artist not found: id=%s".formatted(aggregateId)));
      artist.setIsPublished(artistPublishedEvent.getIsPublished());
      artistDao.update(artist);
      log.info(
          "Processed event successfully: type=ArtistCreatedEvent, aggregateId=%s"
              .formatted(aggregateId));
    };
  }
}
