package vn.io.echovibe.core.model;

public record BusinessRule(String code, String content) {
  public String message() {
    return "%s: %s".formatted(code, content);
  }

  @Override
  public final String toString() {
    return message();
  }
}
