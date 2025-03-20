package vn.io.echovibe.track.command.handler;

import static vn.io.echovibe.track.common.constant.TrackConstant.TRACK_EVENT_TOPIC_PREFIX;

import java.util.Comparator;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.core.event.EventProducer;
import vn.io.echovibe.core.event.EventSourcingHandler;
import vn.io.echovibe.core.event.EventStore;
import vn.io.echovibe.track.command.domain.TrackAggregate;

@RequiredArgsConstructor
@Service
public class TrackEventSourcingHandler implements EventSourcingHandler<TrackAggregate> {
  private final EventProducer eventProducer;

  private final EventStore eventStore;

  @Override
  public void save(TrackAggregate artistAggregate) {
    eventStore.saveEvents(
        artistAggregate.getId(),
        artistAggregate.getUncommittedChanges(),
        artistAggregate.getVersion());
  }

  @Override
  public TrackAggregate findById(String id) {
    final TrackAggregate artistAggregate = new TrackAggregate();
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
      final TrackAggregate artistAggregate = findById(aggregateId);
      if (!artistAggregate.getIsActive()) {
        continue;
      }
      final List<Event> events = eventStore.getEvents(aggregateId);
      for (Event event : events) {
        eventProducer.produce(TRACK_EVENT_TOPIC_PREFIX + event.getClass().getSimpleName(), event);
      }
    }
  }
}
