package vn.io.echovibe.track.command.dto;

import jakarta.validation.constraints.NotNull;

public record TagDto(
    @NotNull(message = "The field 'name of Tag' must not be null.") String name,
    @NotNull(message = "The field 'isActive of Tag' must not be null.") Boolean isActive) {}
