package vn.io.echovibe.web.dto;

import java.time.Instant;
import java.util.List;
import vn.io.echovibe.core.exception.Error;

public record ErrorDto(List<Error> errors, String message, Instant timestamp) {}
