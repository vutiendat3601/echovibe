package vn.io.echovibe.track.command.handler;

import static vn.io.echovibe.track.command.constant.TrackCommandConstant.HIDE_ID_WHEN_ERROR_COMMANDS;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
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
import vn.io.echovibe.track.command.model.CreateTrackCommand;
import vn.io.echovibe.track.command.model.DeleteTrackCommand;
import vn.io.echovibe.track.command.model.ReleaseTrackCommand;
import vn.io.echovibe.track.command.model.UpdateTrackCommand;

@Slf4j
@SuppressWarnings({"rawtypes", "unchecked"})
@RequiredArgsConstructor
@Service
public class TrackCommandDispatcher implements CommandDispatcher {
  private final Map<Class<? extends Command>, CommandHandlerFunction> handlerMap = new HashMap<>();

  private final CommandHandler commandHandler;

  @EventListener(ApplicationReadyEvent.class)
  void onApplicationReadyEvent() {
    registerHandler(CreateTrackCommand.class, commandHandler::handle);
    registerHandler(UpdateTrackCommand.class, commandHandler::handle);
    registerHandler(DeleteTrackCommand.class, commandHandler::handle);
    registerHandler(ReleaseTrackCommand.class, commandHandler::handle);
  }

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
        log.error(Optional.ofNullable(e.getCause()).orElse(e).getMessage(), e);
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
