package vn.io.echovibe.core.dto;

import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import org.springframework.http.HttpStatus;
import org.springframework.lang.NonNull;
import vn.io.echovibe.core.model.BulkResult;
import vn.io.echovibe.core.model.QueryResult;

public record ResponseDto<T>(T data, HttpStatus status, String message, ZonedDateTime timestamp) {
  public ResponseDto(T data, @NonNull String message, @NonNull HttpStatus status) {
    this(data, status, message, ZonedDateTime.now(ZoneOffset.UTC));
  }

  public static ResponseDto<EmptyObjectDto> ok(@NonNull String message) {
    return new ResponseDto<>(new EmptyObjectDto(), message, HttpStatus.OK);
  }

  public static ResponseDto<IdDto> ok(@NonNull String message, @NonNull String id) {
    return new ResponseDto<>(new IdDto(id), message, HttpStatus.OK);
  }

  public static ResponseDto<QueryResult> ok(
      @NonNull String message, @NonNull QueryResult queryResult) {
    return new ResponseDto<>(queryResult, message, HttpStatus.OK);
  }

  public static ResponseDto<BulkResult> ok(
      @NonNull String message, @NonNull BulkResult bulkResult) {
    return new ResponseDto<>(bulkResult, message, HttpStatus.OK);
  }
}
