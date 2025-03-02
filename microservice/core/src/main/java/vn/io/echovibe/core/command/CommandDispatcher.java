package vn.io.echovibe.core.command;

import org.springframework.lang.NonNull;

public interface CommandDispatcher {
  <T extends Command> void registerHandler(
      @NonNull Class<T> type, @NonNull CommandHandlerFunction<T> commandHandler);

  void send(@NonNull Command command);
}
