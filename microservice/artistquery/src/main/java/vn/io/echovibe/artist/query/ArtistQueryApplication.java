package vn.io.echovibe.artist.query;

import static vn.io.echovibe.core.constant.Constant.JPA_AUDIT_DATETIME_PROVIDER_BEAN;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.event.EventListener;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import vn.io.echovibe.artist.query.handler.QueryHandler;
import vn.io.echovibe.artist.query.model.FindArtistByIdsQuery;
import vn.io.echovibe.artist.query.model.FindArtistPageQuery;
import vn.io.echovibe.core.query.QueryDispatcher;

@RequiredArgsConstructor
@ComponentScan("vn.io.echovibe")
@EnableJpaRepositories("vn.io.echovibe")
@EnableTransactionManagement
@EnableJpaAuditing(dateTimeProviderRef = JPA_AUDIT_DATETIME_PROVIDER_BEAN)
@SpringBootApplication
public class ArtistQueryApplication {
  private final QueryDispatcher queryDispatcher;
  private final QueryHandler queryHandler;

  @EventListener(ApplicationReadyEvent.class)
  void registerHandlers() {
    queryDispatcher.registerHandler(FindArtistByIdsQuery.class, queryHandler::handle);
    queryDispatcher.registerHandler(FindArtistPageQuery.class, queryHandler::handle);
  }

  public static void main(String[] args) {
    SpringApplication.run(ArtistQueryApplication.class, args);
  }
}
