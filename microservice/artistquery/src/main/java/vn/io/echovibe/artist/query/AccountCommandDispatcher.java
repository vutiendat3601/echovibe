package vn.io.echovibe.artist.command;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.springframework.lang.NonNull;

import vn.io.echovibe.core.command.Command;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.command.CommandHandlerFunction;

@SuppressWarnings({"rawtypes", "unchecked"})
public class AccountCommandDispatcher implements CommandDispatcher {
  private final Map<Class<? extends Command>, CommandHandlerFunction> handlerMap = new HashMap<>();

  @Override
  public void send(@NonNull Command command) {
    final CommandHandlerFunction commandHandlerFunction = handlerMap.get(command.getClass());
    if (Objects.nonNull(commandHandlerFunction)) {
      commandHandlerFunction.handle(command);
    }
  }

  @Override
  public <T extends Command> void registerHandler(
      @NonNull Class<T> type, @NonNull CommandHandlerFunction<T> commandHandlerFunction) {
    handlerMap.put(type, commandHandlerFunction);
  }
}
