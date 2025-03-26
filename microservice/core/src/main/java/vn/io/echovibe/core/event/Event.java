package vn.io.echovibe.core.event;

import static vn.io.echovibe.core.constant.Constant.AUTH_SYSTEM_USERNAME;

import java.time.Instant;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
@ToString
public abstract class Event {
  protected String id;

  protected int version;

  protected String type;

  @Builder.Default protected String createdBy = AUTH_SYSTEM_USERNAME;

  @Builder.Default protected Instant timestamp = ZonedDateTime.now(ZoneOffset.UTC).toInstant();
}
