package vn.io.echovibe.track.command.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.util.List;

public record CreateTrackDto(
    @NotNull(message = "The field 'detail' must not be null.") TrackDetailDto detail,
    Boolean isPublic,
    @Valid @NotNull(message = "The field 'tags' must not be null.") List<@NotNull TagDto> tags,
    String refCode,
    @NotNull(message = "The field 'trackArtists' must not be null.")
        List<TrackArtistDto> trackArtists) {}
