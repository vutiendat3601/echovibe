package vn.io.echovibe.artist.command.dto;

import jakarta.validation.constraints.NotBlank;

public record DeleteArtistDto(@NotBlank(message = "The 'id' field must not be blank.") String id) {}
