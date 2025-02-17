package vn.io.echovibe.core.event;

@FunctionalInterface
public interface EventProducer {
  void send(String topic, Event event);
}
