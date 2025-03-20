package vn.io.echovibe.track.command.dto;

import jakarta.validation.constraints.NotNull;
import java.util.List;

public record CreateTrackDto(
    @NotNull(message = "The field 'detail' must not be null.") CreateTrackDetailDto detail,
    @NotNull(message = "The field 'artistIds' must not be null.") List<String> artistIds) {}
