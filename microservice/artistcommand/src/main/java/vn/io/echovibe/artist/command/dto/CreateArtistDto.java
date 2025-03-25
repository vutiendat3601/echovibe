package vn.io.echovibe.artist.command.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.util.List;

public record CreateArtistDto(
    String refCode,
    Boolean isVerified,
    Boolean isPublic,
    @NotNull(message = "The field 'tags' must not be null.") List<String> tags,
    @Valid @NotNull(message = "The field 'profile' must not be null.")
        CreateArtistProfileDto profile) {}
