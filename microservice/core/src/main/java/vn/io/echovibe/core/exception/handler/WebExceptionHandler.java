package vn.io.echovibe.core.exception.handler;

import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import vn.io.echovibe.core.dto.ErrorDto;
import vn.io.echovibe.core.exception.AggregateNotFoundException;
import vn.io.echovibe.core.exception.Error;
import vn.io.echovibe.core.exception.NoneFieldChangedException;

@Slf4j
@RestControllerAdvice
public class WebExceptionHandler {
  @ExceptionHandler(RuntimeException.class)
  public ResponseEntity<ErrorDto> handleRuntimeException(RuntimeException e) {
    log.error(e.getMessage(), e);
    return ResponseEntity.badRequest()
        .body(
            new ErrorDto(
                List.of(),
                "Internal server error. Please contact to developer team for more information.",
                ZonedDateTime.now(ZoneOffset.UTC)));
  }

  @ExceptionHandler(MethodArgumentNotValidException.class)
  public ResponseEntity<ErrorDto> handleMethodArgumentNotValidException(
      MethodArgumentNotValidException e) {
    final List<Error> errors =
        e.getAllErrors().stream()
            .map(error -> new Error(error.getDefaultMessage(), error.getObjectName()))
            .toList();
    return ResponseEntity.badRequest()
        .body(
            new ErrorDto(
                errors,
                "Bad request, please check the API documentation or contact the developer team.",
                ZonedDateTime.now(ZoneOffset.UTC)));
  }

  @ExceptionHandler(NoneFieldChangedException.class)
  public ResponseEntity<ErrorDto> handleMethodArgumentNotValidException(
      NoneFieldChangedException e) {
    return ResponseEntity.badRequest()
        .body(
            new ErrorDto(
                List.of(),
                """
There are no fields that have been changed in your update request. Please check the API documentation or contact the development team.""",
                ZonedDateTime.now(ZoneOffset.UTC)));
  }

  @ExceptionHandler(AggregateNotFoundException.class)
  public ResponseEntity<ErrorDto> handleMethodArgumentNotValidException(
      AggregateNotFoundException e) {
    return ResponseEntity.status(HttpStatus.NOT_FOUND)
        .body(new ErrorDto(List.of(), e.getMessage(), ZonedDateTime.now(ZoneOffset.UTC)));
  }
}
