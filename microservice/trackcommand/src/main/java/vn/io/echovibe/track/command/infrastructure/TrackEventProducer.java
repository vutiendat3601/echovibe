package vn.io.echovibe.track.command.infrastructure;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.core.event.EventProducer;
import vn.io.echovibe.web.context.JwtSecurityHolder;

@Slf4j
@Service
@RequiredArgsConstructor
public class TrackEventProducer implements EventProducer {
  private final StreamBridge streamBridge;

  @Override
  public void produce(String topic, Event event) {
    event.setCreatedBy(JwtSecurityHolder.getSubject());
    log.info(
        "Send event: topic=%s, eventId=%s, eventVersion=%d, createdBy=%s"
            .formatted(topic, event.getId(), event.getVersion(), event.getCreatedBy()));
    streamBridge.send(topic, event, MediaType.APPLICATION_JSON);
    log.info(
        "Sent event successfully: topic=%s, eventId=%s, eventVersion=%d, createdBy=%s"
            .formatted(topic, event.getId(), event.getVersion(), event.getCreatedBy()),
        event.getVersion());
  }
}
