package vn.io.echovibe.artist.command.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

public record CreateArtistDto(
    @Valid @NotNull(message = "The field 'profile' must not be null.")
        CreateArtistProfileDto profile) {}
