package vn.io.echovibe.core.event;

import java.time.Instant;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Document(collection = "eventStore")
public class EventDocument {
  @Id private String id;

  @Builder.Default private Instant timestamp = ZonedDateTime.now(ZoneOffset.UTC).toInstant();

  private String aggregateId;

  private String aggregateType;

  private int version;

  private String eventType;

  private Event event;
}
