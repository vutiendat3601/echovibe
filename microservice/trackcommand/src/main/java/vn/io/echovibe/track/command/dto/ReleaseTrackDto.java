package vn.io.echovibe.track.command.dto;

import jakarta.validation.constraints.NotBlank;

public record ReleaseTrackDto(
    @NotBlank(message = "The field 'id' must not be null or blank.") String id) {}
