package vn.io.echovibe.core.event;

import vn.io.echovibe.core.domain.AggregateRoot;

public interface EventSourcingHandler<T extends AggregateRoot> {
  void save(T aggregateRoot);

  T findById(String id);

  void republishEvents();
}
