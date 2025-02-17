package vn.io.echovibe.core.exception;

public class NoneFieldChangedException extends RuntimeException {
  public NoneFieldChangedException() {
    super("None of fields have been changed.");
  }

  public NoneFieldChangedException(String message) {
    super(message);
  }
}
