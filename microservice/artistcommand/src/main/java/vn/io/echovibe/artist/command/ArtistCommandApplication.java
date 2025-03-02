package vn.io.echovibe.artist.command;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.event.EventListener;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import vn.io.echovibe.artist.command.handler.CommandHandler;
import vn.io.echovibe.artist.command.model.CreateArtistCommand;
import vn.io.echovibe.artist.command.model.DeleteArtistCommand;
import vn.io.echovibe.artist.command.model.PublishArtistCommand;
import vn.io.echovibe.artist.command.model.UpdateArtistCommand;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.domain.EventStoreRepository;

@ComponentScan("vn.io.echovibe")
@EnableMongoRepositories(basePackageClasses = EventStoreRepository.class)
@EnableTransactionManagement
@RequiredArgsConstructor
@SpringBootApplication
public class ArtistCommandApplication {
  private final CommandDispatcher commandDispatcher;
  private final CommandHandler commandHandler;

  @EventListener(ApplicationReadyEvent.class)
  void registerHandlers() {
    commandDispatcher.registerHandler(CreateArtistCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(UpdateArtistCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(PublishArtistCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(DeleteArtistCommand.class, commandHandler::handle);
  }

  public static void main(String[] args) {
    SpringApplication.run(ArtistCommandApplication.class, args);
  }
}
