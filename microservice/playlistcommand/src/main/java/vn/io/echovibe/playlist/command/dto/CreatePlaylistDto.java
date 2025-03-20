package vn.io.echovibe.playlist.command.dto;

import jakarta.validation.constraints.NotNull;

public record CreatePlaylistDto(
    @NotNull(message = "The field 'detail' must not bee null.") CreatePlaylistDetailDto detail) {}
