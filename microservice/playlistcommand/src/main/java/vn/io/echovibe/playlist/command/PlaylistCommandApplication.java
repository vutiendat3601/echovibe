package vn.io.echovibe.playlist.command;

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
import vn.io.echovibe.playlist.command.handler.CommandHandler;
import vn.io.echovibe.playlist.command.model.SetPlaylistVisibilityCommand;
import vn.io.echovibe.playlist.command.model.CreatePlaylistCommand;
import vn.io.echovibe.playlist.command.model.DeletePlaylistCommand;
import vn.io.echovibe.playlist.command.model.ReleasePlaylistCommand;
import vn.io.echovibe.playlist.command.model.UpdatePlaylistDetailCommand;

@ComponentScan("vn.io.echovibe")
@EnableMongoRepositories(basePackageClasses = EventStoreRepository.class)
@EnableTransactionManagement
@RequiredArgsConstructor
@SpringBootApplication
public class PlaylistCommandApplication {
  private final CommandDispatcher commandDispatcher;
  private final CommandHandler commandHandler;

  @EventListener(ApplicationReadyEvent.class)
  void registerHandlers() {
    commandDispatcher.registerHandler(CreatePlaylistCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(UpdatePlaylistDetailCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(DeletePlaylistCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(ReleasePlaylistCommand.class, commandHandler::handle);
    commandDispatcher.registerHandler(
        SetPlaylistVisibilityCommand.class, commandHandler::handle);
  }

  public static void main(String[] args) {
    SpringApplication.run(PlaylistCommandApplication.class, args);
  }
}
