package vn.io.echovibe.core.dto;

import java.time.ZonedDateTime;

public record ResponseDto<T>(T data, String message, ZonedDateTime timestamp) {
  private static final Object EMPTY_OBJECT = new Object();

  public ResponseDto(T data, String message) {
    this(data, message, ZonedDateTime.now());
  }

  public static ResponseDto<?> ok(String message) {
    return new ResponseDto<>(EMPTY_OBJECT, message);
  }
}
