package vn.io.echovibe.artist.command.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import vn.io.echovibe.core.annotation.NullOrNotBlank;

public record CreateArtistDto(
    @NullOrNotBlank(message = "The field 'refCode' must not be blank.") String refCode,
    @Valid @NotNull(message = "The field 'profile' must not be null.")
        CreateArtistProfileDto profile) {}
