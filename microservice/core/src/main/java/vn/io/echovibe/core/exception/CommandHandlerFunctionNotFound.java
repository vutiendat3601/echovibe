package vn.io.echovibe.core.exception;

public class CommandHandlerFunctionNotFound extends RuntimeException {
  public CommandHandlerFunctionNotFound(String message) {
    super(message);
  }
}
