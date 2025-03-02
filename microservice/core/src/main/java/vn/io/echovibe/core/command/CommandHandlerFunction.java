package vn.io.echovibe.core.command;

@FunctionalInterface
public interface CommandHandlerFunction<T extends Command> {
  void handle(T command);
}
