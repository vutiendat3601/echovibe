package vn.io.echovibe.artist.command.infrastructure;

import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.core.event.EventProducer;

@Service
@RequiredArgsConstructor
public class ArtistEventProducer implements EventProducer {
  private final StreamBridge streamBridge;

  @Override
  public void send(String topic, Event event) {
    streamBridge.send(topic, event);
  }
}
