package vn.io.echovibe.track.command;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.event.EventListener;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.domain.EventStoreRepository;
import vn.io.echovibe.track.command.handler.CommandHandler;
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.SetTrackVisibilityCommand;
import vn.io.echovibe.track.command.model.UpdateTrackDetailCommand;

@ComponentScan("vn.io.echovibe")
@EnableMongoRepositories(basePackageClasses = EventStoreRepository.class)
@EnableTransactionManagement
@RequiredArgsConstructor
@SpringBootApplication
public class TrackCommandApplication {
  private final CommandDispatcher commandDispatcher;
  private final CommandHandler commandHandler;

  @EventListener(ApplicationReadyEvent.class)
  void registerHandlers() {
    commandDispatcher.registerHandler(CreateTrackCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(UpdateTrackDetailCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(DeleteTrackCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(ReleaseTrackCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(SetTrackVisibilityCommand.class, commandHandler::handle);
  }

  public static void main(String[] args) {
    SpringApplication.run(TrackCommandApplication.class, args);
  }
}
