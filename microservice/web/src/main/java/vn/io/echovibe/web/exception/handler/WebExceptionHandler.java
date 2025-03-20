package vn.io.echovibe.web.exception.handler;

import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.LinkedList;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.HandlerMethodValidationException;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import vn.io.echovibe.core.exception.AggregateNotFoundException;
import vn.io.echovibe.core.exception.BusinessRuleViolationException;
import vn.io.echovibe.core.exception.Error;
import vn.io.echovibe.web.dto.ErrorDto;

@Slf4j
@RestControllerAdvice
public class WebExceptionHandler {
  private static final String BAD_REQUEST_ERROR_MESSAGE =
      "Bad request, please check the API documentation or contact the developer team.";

  @ExceptionHandler(RuntimeException.class)
  public ResponseEntity<ErrorDto> handleRuntimeException(RuntimeException e) {
    log.error(e.getMessage(), e);
    return ResponseEntity.badRequest()
        .body(
            new ErrorDto(
                List.of(),
                "Internal server error. Please contact to developer team for more information.",
                ZonedDateTime.now(ZoneOffset.UTC).toInstant()));
  }

  @ExceptionHandler(MissingServletRequestParameterException.class)
  public ResponseEntity<ErrorDto> handleMissingServletRequestParameterException(
      MissingServletRequestParameterException e) {
    final List<Error> errors = new LinkedList<>();
    return ResponseEntity.badRequest()
        .body(new ErrorDto(errors, e.getMessage(), ZonedDateTime.now(ZoneOffset.UTC).toInstant()));
  }

  @ExceptionHandler(MethodArgumentNotValidException.class)
  public ResponseEntity<ErrorDto> handleMethodArgumentNotValidException(
      MethodArgumentNotValidException e) {
    log.info(e.getMessage());
    final List<Error> errors =
        e.getAllErrors().stream()
            .map(error -> new Error(null, error.getDefaultMessage(), error.getObjectName()))
            .toList();
    return ResponseEntity.badRequest()
        .body(
            new ErrorDto(
                errors, BAD_REQUEST_ERROR_MESSAGE, ZonedDateTime.now(ZoneOffset.UTC).toInstant()));
  }

  @ExceptionHandler(MethodArgumentTypeMismatchException.class)
  public ResponseEntity<ErrorDto> handleMethodArgumentTypeMismatchException(
      MethodArgumentTypeMismatchException e) {
    log.info(e.getMessage());
    final List<Error> errors = List.of(new Error(null, e.getMessage(), e.getName()));
    return ResponseEntity.badRequest()
        .body(
            new ErrorDto(
                errors, BAD_REQUEST_ERROR_MESSAGE, ZonedDateTime.now(ZoneOffset.UTC).toInstant()));
  }

  @ExceptionHandler(HandlerMethodValidationException.class)
  public ResponseEntity<ErrorDto> handHandlerMethodValidationException(
      HandlerMethodValidationException e) {
    log.info(e.getMessage());
    final List<Error> errors =
        e.getAllErrors().stream()
            .map(error -> new Error(null, error.getDefaultMessage(), null))
            .toList();
    return ResponseEntity.badRequest()
        .body(
            new ErrorDto(
                errors, BAD_REQUEST_ERROR_MESSAGE, ZonedDateTime.now(ZoneOffset.UTC).toInstant()));
  }

  @ExceptionHandler(HttpMessageNotReadableException.class)
  public ResponseEntity<ErrorDto> handleHttpMessageNotReadableException(
      HttpMessageNotReadableException e) {
    log.error(e.getMessage(), e);
    return ResponseEntity.badRequest()
        .body(
            new ErrorDto(
                List.of(),
                BAD_REQUEST_ERROR_MESSAGE,
                ZonedDateTime.now(ZoneOffset.UTC).toInstant()));
  }

  @ExceptionHandler(BusinessRuleViolationException.class)
  public ResponseEntity<ErrorDto> handleMethodArgumentNotValidException(
      BusinessRuleViolationException e) {
    log.error(e.getMessage(), e);
    return ResponseEntity.badRequest()
        .body(
            new ErrorDto(
                List.of(new Error(e.getBusinessRule(), e.getMessage(), null)),
                """
There are no fields that have been changed in your update request. Please check the API documentation or contact the development team.""",
                ZonedDateTime.now(ZoneOffset.UTC).toInstant()));
  }

  @ExceptionHandler(AggregateNotFoundException.class)
  public ResponseEntity<ErrorDto> handleMethodArgumentNotValidException(
      AggregateNotFoundException e) {
    log.error(e.getMessage(), e);
    return ResponseEntity.status(HttpStatus.NOT_FOUND)
        .body(
            new ErrorDto(List.of(), e.getMessage(), ZonedDateTime.now(ZoneOffset.UTC).toInstant()));
  }
}
