package vn.io.echovibe.artist.command.infrastructure;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.stereotype.Service;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.core.event.EventProducer;

@Slf4j
@Service
@RequiredArgsConstructor
public class ArtistEventProducer implements EventProducer {
  private final StreamBridge streamBridge;

  @Override
  public void produce(String topic, Event event) {
    log.info("Send event: topic=%s, eventId=%s".formatted(topic, event.getId()));
    streamBridge.send(topic, event);
    log.info("Sent event successfully: topic=%s, eventId=%s".formatted(topic, event.getId()));
  }
}
