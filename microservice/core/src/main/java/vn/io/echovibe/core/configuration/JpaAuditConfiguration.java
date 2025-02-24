package vn.io.echovibe.core.configuration;

import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.Optional;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.auditing.DateTimeProvider;

@Configuration
public class JpaAuditConfiguration {
  @Bean
  DateTimeProvider dateTimeProvider() {
    return () -> Optional.of(ZonedDateTime.now(ZoneOffset.UTC).toInstant());
  }
}
