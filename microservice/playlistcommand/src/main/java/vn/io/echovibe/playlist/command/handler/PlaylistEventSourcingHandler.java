package vn.io.echovibe.playlist.command.handler;

import static vn.io.echovibe.playlist.common.constant.PlaylistConstant.PLAYLIST_EVENT_TOPIC_PREFIX;

import java.util.Comparator;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.core.event.EventProducer;
import vn.io.echovibe.core.event.EventSourcingHandler;
import vn.io.echovibe.core.event.EventStore;
import vn.io.echovibe.playlist.command.domain.PlaylistAggregate;

@RequiredArgsConstructor
@Service
public class PlaylistEventSourcingHandler implements EventSourcingHandler<PlaylistAggregate> {
  private final EventProducer eventProducer;

  private final EventStore eventStore;

  @Override
  public void save(PlaylistAggregate playlistAggregate) {
    eventStore.saveEvents(
        playlistAggregate.getId(),
        playlistAggregate.getUncommittedChanges(),
        playlistAggregate.getVersion());
  }

  @Override
  public PlaylistAggregate findById(String id) {
    final PlaylistAggregate playlistAggregate = new PlaylistAggregate();
    final List<Event> events = eventStore.getEvents(id);
    if (!CollectionUtils.isEmpty(events)) {
      playlistAggregate.replayEvents(events);
      events.stream()
          .map(e -> e.getVersion())
          .max(Comparator.naturalOrder())
          .ifPresent(latestVersion -> playlistAggregate.setVersion(latestVersion));
    }
    return playlistAggregate;
  }

  @Override
  public void republishEvents() {
    final List<String> aggregateIds = eventStore.getAggregateIds();
    for (String aggregateId : aggregateIds) {
      final PlaylistAggregate playlistAggregate = findById(aggregateId);
      if (!playlistAggregate.getIsActive()) {
        continue;
      }
      final List<Event> events = eventStore.getEvents(aggregateId);
      for (Event event : events) {
        eventProducer.produce(
            PLAYLIST_EVENT_TOPIC_PREFIX + event.getClass().getSimpleName(), event);
      }
    }
  }
}
