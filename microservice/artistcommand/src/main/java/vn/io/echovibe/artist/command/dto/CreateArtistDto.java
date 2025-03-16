package vn.io.echovibe.artist.command.dto;

import jakarta.validation.constraints.NotNull;

public record CreateArtistDto(
    @NotNull(message = "The field 'profile' must not be null.") CreateArtistProfileDto profile) {}
