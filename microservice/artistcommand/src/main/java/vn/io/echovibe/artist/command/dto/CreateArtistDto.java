package vn.io.echovibe.artist.command.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record CreateArtistDto(
    @NotBlank(message = "The 'name' field is required and must not be blank.") String name,
    @NotNull(message = "The field 'isPublic' must not be null.") Boolean isPublic,
    String description) {}
