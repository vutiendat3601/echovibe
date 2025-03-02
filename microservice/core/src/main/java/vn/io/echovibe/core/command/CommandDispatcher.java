package vn.io.echovibe.core.command;

import java.util.List;

import org.springframework.lang.NonNull;

import vn.io.echovibe.core.model.BulkResult;

public interface CommandDispatcher {
  <T extends Command> void registerHandler(
      @NonNull Class<T> type, @NonNull CommandHandlerFunction<T> commandHandler);

  void send(@NonNull Command command);

  BulkResult send(@NonNull List<? extends Command> commands);
}
