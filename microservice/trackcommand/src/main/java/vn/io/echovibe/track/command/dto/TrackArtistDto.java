package vn.io.echovibe.track.command.dto;

import jakarta.validation.constraints.NotNull;

public record TrackArtistDto(
    String artistId,
    String artistRefCode,
    @NotNull(message = "The field 'isMainArtist' must not be null.") Boolean isMainArtist,
    @NotNull(message = "The field 'isActive' must not be null.") Boolean isActive) {}
