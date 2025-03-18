package vn.io.echovibe.artist.command.dto;

import jakarta.validation.constraints.NotBlank;

public record DeleteArtistDto(
    @NotBlank(message = "The field 'id' must not be null or blank.") String id) {}
