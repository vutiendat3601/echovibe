package vn.io.echovibe.track.command.dto;

import jakarta.validation.constraints.NotBlank;

public record DeleteTrackDto(@NotBlank(message = "The 'id' field must not be blank.") String id) {}
