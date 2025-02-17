package vn.io.echovibe.core.dto;

import java.time.ZonedDateTime;
import java.util.List;
import vn.io.echovibe.core.exception.Error;

public record ErrorDto(List<Error> errors, String message, ZonedDateTime timestamp) {}
