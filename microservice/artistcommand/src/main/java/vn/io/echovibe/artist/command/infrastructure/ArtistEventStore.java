package vn.io.echovibe.artist.command.infrastructure;

import static vn.io.echovibe.artist.command.constant.ArtistConstant.ARTIST_EVENT_TOPIC_PREFIX;

import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import vn.io.echovibe.artist.command.domain.ArtistAggregate;
import vn.io.echovibe.core.domain.EventStoreRepository;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.core.event.EventDocument;
import vn.io.echovibe.core.event.EventProducer;
import vn.io.echovibe.core.event.EventStore;
import vn.io.echovibe.core.exception.AggregateNotFoundException;

@RequiredArgsConstructor
@Service
public class ArtistEventStore implements EventStore {
  private final EventProducer eventProducer;

  private final EventStoreRepository eventStoreRepository;

  @Override
  public void saveEvents(String aggregateId, Iterable<Event> events, int expectedVersion) {
    final List<EventDocument> eventDocuments = eventStoreRepository.findByAggregateId(aggregateId);
    if (expectedVersion != -1
        && eventDocuments.get(eventDocuments.size() - 1).getVersion() != expectedVersion) {
      throw new RuntimeException();
    }
    int version = expectedVersion;
    for (Event event : events) {
      version++;
      event.setVersion(version);
      EventDocument eventDocument =
          EventDocument.builder()
              .aggregateId(aggregateId)
              .aggregateType(ArtistAggregate.class.getTypeName())
              .version(version)
              .eventType(event.getClass().getTypeName())
              .event(event)
              .build();
      eventDocument = eventStoreRepository.save(eventDocument);
      if (!eventDocument.getId().isEmpty()) {
        final String eventTopic = ARTIST_EVENT_TOPIC_PREFIX + event.getClass().getSimpleName();
        eventProducer.send(eventTopic, event);
      }
    }
  }

  @Override
  public List<Event> getEvents(String aggregateId) {
    final List<EventDocument> eventDocuments = eventStoreRepository.findByAggregateId(aggregateId);
    if (CollectionUtils.isEmpty(eventDocuments)) {
      throw new AggregateNotFoundException(
          "Incorrect artist id provided: id=%s".formatted(aggregateId));
    }
    return eventDocuments.stream().map(EventDocument::getEvent).collect(Collectors.toList());
  }

  @Override
  public List<String> getAggregateIds() {
    final List<EventDocument> eventDocuments = eventStoreRepository.findAll();
    if (CollectionUtils.isEmpty(eventDocuments)) {
      throw new IllegalStateException("Could not retrieve event from the event store");
    }
    return eventDocuments.stream()
        .map(EventDocument::getAggregateId)
        .distinct()
        .collect(Collectors.toList());
  }
}
