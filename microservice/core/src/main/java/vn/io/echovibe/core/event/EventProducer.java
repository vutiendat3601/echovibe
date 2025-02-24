package vn.io.echovibe.core.event;

@FunctionalInterface
public interface EventProducer {
  void produce(String topic, Event event);
}
