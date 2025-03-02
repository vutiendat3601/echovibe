package vn.io.echovibe.artist.command.dto;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotBlank;

public record UpdateArtistDto(
    @Nullable @NotBlank(message = "The 'name' field must not be blank.") String name,
    Boolean isPublic,
    String description) {}
