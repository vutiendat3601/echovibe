package vn.io.echovibe.playlist.command.handler;

import static vn.io.echovibe.playlist.command.constant.PlaylistCommandConstant.HIDE_ID_WHEN_ERROR_COMMANDS;

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
import vn.io.echovibe.core.exception.BusinessRuleViolationException;
import vn.io.echovibe.core.exception.CommandHandlerFunctionNotFound;
import vn.io.echovibe.core.exception.Error;
import vn.io.echovibe.core.model.BulkResult;
import vn.io.echovibe.core.model.CommandResult;

@SuppressWarnings({"rawtypes", "unchecked"})
@Service
public class PlaylistCommandDispatcher implements CommandDispatcher {
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
      final CommandResult commandResult =
          CommandResult.builder()
              .id(id)
              .command(commandType)
              .isSuccessful(true)
              .message(message)
              .build();
      try {
        send(command);
      } catch (BusinessRuleViolationException e) {
        message =
            "Command '%s' was processed unsuccessfully: %s"
                .formatted(commandType, Optional.ofNullable(e.getCause()).orElse(e).getMessage());
        final List<Error> errors = List.of(new Error(e.getBusinessRule(), e.getMessage(), null));
        commandResult.setErrors(errors);
        commandResult.setMessage(message);
        commandResult.setIsSuccessful(false);
      } catch (Exception e) {
        message =
            "Command '%s' was processed unsuccessfully: %s"
                .formatted(commandType, Optional.ofNullable(e.getCause()).orElse(e).getMessage());
        commandResult.setErrors(List.of());
        commandResult.setMessage(message);
        commandResult.setIsSuccessful(false);
      }
      processCommandResult(commandResult);
      items.add(commandResult);
    }
    return new BulkResult(items);
  }

  private void processCommandResult(CommandResult commandResult) {
    if (commandResult.getIsSuccessful()) {
      return;
    }
    if (HIDE_ID_WHEN_ERROR_COMMANDS.contains(commandResult.getCommand())) {
      commandResult.setId(null);
    }
  }
}
