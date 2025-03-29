package vn.io.echovibe.core.event;

public interface EventGetter {
  default String getType() {
    return getClass().getSimpleName();
  }
}
