package vn.io.echovibe.track.command.infrastructure;

import static vn.io.echovibe.core.constant.Constant.AUTH_SYSTEM_USERNAME;
import static vn.io.echovibe.track.common.constant.TrackConstant.TRACK_EVENT_TOPIC_PREFIX;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import vn.io.echovibe.core.domain.EventStoreRepository;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.core.event.EventDocument;
import vn.io.echovibe.core.event.EventProducer;
import vn.io.echovibe.core.event.EventStore;
import vn.io.echovibe.core.exception.AggregateNotFoundException;
import vn.io.echovibe.track.command.domain.TrackAggregate;
import vn.io.echovibe.web.context.JwtSecurityHolder;

@RequiredArgsConstructor
@Service
public class TrackEventStore implements EventStore {
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
      event.setCreatedBy(
          Optional.ofNullable(JwtSecurityHolder.getSubject()).orElse(AUTH_SYSTEM_USERNAME));
      EventDocument eventDocument =
          EventDocument.builder()
              .aggregateId(aggregateId)
              .aggregateType(TrackAggregate.class.getTypeName())
              .version(version)
              .eventType(event.getClass().getTypeName())
              .event(event)
              .createdBy(event.getCreatedBy())
              .build();
      eventDocument = eventStoreRepository.save(eventDocument);
      if (!eventDocument.getId().isEmpty()) {
        final String eventTopic = TRACK_EVENT_TOPIC_PREFIX + event.getClass().getSimpleName();
        eventProducer.produce(eventTopic, event);
      }
    }
  }

  @Override
  public List<Event> getEvents(String aggregateId) {
    final List<EventDocument> eventDocuments = eventStoreRepository.findByAggregateId(aggregateId);
    if (CollectionUtils.isEmpty(eventDocuments)) {
      throw new AggregateNotFoundException("Track not found: id=%s".formatted(aggregateId));
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
