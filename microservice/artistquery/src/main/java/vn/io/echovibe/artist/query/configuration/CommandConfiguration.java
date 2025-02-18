package vn.io.echovibe.artist.configuration;

import org.springframework.context.annotation.Configuration;

import jakarta.annotation.PostConstruct;
import vn.io.echovibe.artist.command.ArtistCommandHandler;
import vn.io.echovibe.artist.command.CreateArtistCommand;
import vn.io.echovibe.artist.command.UpdateArtistCommand;
import vn.io.echovibe.core.command.CommandDispatcher;

@Configuration
public class CommandConfiguration {
  @PostConstruct
  void registerHandler(CommandDispatcher commandDispatcher, ArtistCommandHandler artistCommandHandler) {
    commandDispatcher.registerHandler(CreateArtistCommand.class, artistCommandHandler::handle);
    commandDispatcher.registerHandler(UpdateArtistCommand.class, artistCommandHandler::handle);
  }
}
