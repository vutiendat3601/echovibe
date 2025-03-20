package vn.io.echovibe.artist.command.handler;

import static vn.io.echovibe.artist.common.constant.ArtistConstant.ARTIST_EVENT_TOPIC_PREFIX;

import java.util.Comparator;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import vn.io.echovibe.artist.command.domain.ArtistAggregate;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.core.event.EventProducer;
import vn.io.echovibe.core.event.EventSourcingHandler;
import vn.io.echovibe.core.event.EventStore;

@RequiredArgsConstructor
@Service
public class ArtistEventSourcingHandler implements EventSourcingHandler<ArtistAggregate> {
  private final EventProducer eventProducer;

  private final EventStore eventStore;

  @Override
  public void save(ArtistAggregate artistAggregate) {
    eventStore.saveEvents(
        artistAggregate.getId(),
        artistAggregate.getUncommittedChanges(),
        artistAggregate.getVersion());
  }

  @Override
  public ArtistAggregate findById(String id) {
    final ArtistAggregate artistAggregate = new ArtistAggregate();
    final List<Event> events = eventStore.getEvents(id);
    if (!CollectionUtils.isEmpty(events)) {
      artistAggregate.replayEvents(events);
      events.stream()
          .map(e -> e.getVersion())
          .max(Comparator.naturalOrder())
          .ifPresent(latestVersion -> artistAggregate.setVersion(latestVersion));
    }
    return artistAggregate;
  }

  @Override
  public void republishEvents() {
    final List<String> aggregateIds = eventStore.getAggregateIds();
    for (String aggregateId : aggregateIds) {
      final ArtistAggregate artistAggregate = findById(aggregateId);
      if (!artistAggregate.getIsActive()) {
        continue;
      }
      final List<Event> events = eventStore.getEvents(aggregateId);
      for (Event event : events) {
        eventProducer.produce(ARTIST_EVENT_TOPIC_PREFIX + event.getClass().getSimpleName(), event);
      }
    }
  }
}
