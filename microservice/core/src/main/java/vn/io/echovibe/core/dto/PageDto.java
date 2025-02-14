package vn.io.echovibe.core.dto;

import java.time.ZonedDateTime;
import java.util.Map;

public record PageDto<T>(
    Iterable<T> items,
    int page,
    int size,
    String path,
    Map<String, ?> query,
    ZonedDateTime timestamp) {
  public PageDto(Iterable<T> items, int page, int size, String path, Map<String, ?> query) {
    this(items, page, size, path, query, ZonedDateTime.now());
  }
}
