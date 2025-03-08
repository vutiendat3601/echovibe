package vn.io.echovibe.core.event;

import static vn.io.echovibe.core.constant.Constant.AUTH_SYSTEM_USERNAME;

import java.time.Instant;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.Optional;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import vn.io.echovibe.core.context.JwtSecurityHolder;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Document(collection = "event_document")
public class EventDocument {
  @Id private String id;

  @Builder.Default
  protected String createdBy =
      Optional.ofNullable(JwtSecurityHolder.getJwtUsername()).orElse(AUTH_SYSTEM_USERNAME);

  @Builder.Default private Instant timestamp = ZonedDateTime.now(ZoneOffset.UTC).toInstant();

  private String aggregateId;

  private String aggregateType;

  private int version;

  private String eventType;

  private Event event;
}
