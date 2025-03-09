package vn.io.echovibe.artist.command.handler;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import vn.io.echovibe.core.command.Command;
import vn.io.echovibe.core.command.CommandDispatcher;
import vn.io.echovibe.core.command.CommandHandlerFunction;
import vn.io.echovibe.core.exception.CommandHandlerFunctionNotFound;
import vn.io.echovibe.core.model.BulkResult;
import vn.io.echovibe.core.model.CommandResult;

@SuppressWarnings({"rawtypes", "unchecked"})
@Service
public class ArtistCommandDispatcher implements CommandDispatcher {
  private final Map<Class<? extends Command>, CommandHandlerFunction> handlerMap = new HashMap<>();

  @Override
  public <T extends Command> void registerHandler(
      @NonNull Class<T> type, @NonNull CommandHandlerFunction<T> commandHandlerFunction) {
    handlerMap.put(type, commandHandlerFunction);
  }

  @SuppressWarnings("static-access")
  @Override
  public void send(@NonNull Command command) {
    final Class<? extends Command> commandClass = command.getClass();
    final CommandHandlerFunction commandHandlerFunction = handlerMap.get(commandClass);
    if (Objects.isNull(commandHandlerFunction)) {
      throw new CommandHandlerFunctionNotFound(
          "Command hanlder function not found: commandType=%s"
              .format(commandClass.getSimpleName()));
    }
    commandHandlerFunction.handle(command);
  }

  @Override
  public BulkResult send(@NonNull List<? extends Command> commands) {
    final List<CommandResult> items = new LinkedList<>();
    for (Command command : commands) {
      final String id = command.getId();
      final String commandType = command.getClass().getSimpleName();
      String message =
          "Command '%s' was processed successfully: aggregateId=%s"
              .formatted(commandType, command.getId());
      try {
        send(command);
        items.add(new CommandResult(id, commandType, true, message));
      } catch (Exception e) {
        message =
            "Command '%s' was process unsuccessfully: %s"
                .formatted(commandType, Optional.ofNullable(e.getCause()).orElse(e).getMessage());
        items.add(new CommandResult(id, commandType, false, message));
      }
    }
    return new BulkResult(items);
  }
}
