package vn.io.echovibe.artist.command.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record SetArtistVisibilityDto(
    @NotBlank(message = "The field 'id' must not be null or blank.") String id,
    @NotNull(message = "The field 'isPublic' must not be null.") Boolean isPublic) {}
