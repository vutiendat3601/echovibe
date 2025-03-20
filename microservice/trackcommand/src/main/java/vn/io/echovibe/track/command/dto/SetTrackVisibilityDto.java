package vn.io.echovibe.track.command.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record SetTrackVisibilityDto(
    @NotBlank(message = "The field 'id' must not be null or blank.") String id,
    @NotNull(message = "The field 'isPublic' must not be null.") Boolean isPublic) {}
