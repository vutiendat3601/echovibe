package vn.io.echovibe.playlist.command.dto;

import jakarta.validation.constraints.NotBlank;

public record DeletePlaylistDto(@NotBlank(message = "The 'id' field must not be blank.") String id) {}
