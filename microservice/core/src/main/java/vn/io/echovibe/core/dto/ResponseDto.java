package vn.io.echovibe.core.dto;

import java.time.ZoneOffset;
import java.time.ZonedDateTime;

import org.springframework.http.HttpStatus;

public record ResponseDto<T>(T data, HttpStatus status, String message, ZonedDateTime timestamp) {
  public ResponseDto(T data, String message, HttpStatus status) {
    this(data, status, message, ZonedDateTime.now(ZoneOffset.UTC));
  }

  public static ResponseDto<?> ok(String message) {
    return new ResponseDto<>(null, message, HttpStatus.OK);
  }

  public static ResponseDto<IdDto> ok(String message, String id) {
    return new ResponseDto<>(new IdDto(id), message, HttpStatus.OK);
  }
}
