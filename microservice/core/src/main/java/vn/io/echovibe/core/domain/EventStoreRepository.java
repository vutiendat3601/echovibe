package vn.io.echovibe.core.domain;

import java.util.List;
import org.springframework.data.mongodb.repository.MongoRepository;
import vn.io.echovibe.core.event.EventDocument;

public interface EventStoreRepository extends MongoRepository<EventDocument, String> {
  List<EventDocument> findByAggregateId(String aggregateId);
}
