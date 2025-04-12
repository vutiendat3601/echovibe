package vn.io.echovibe.track.command.dto;

import jakarta.validation.constraints.NotBlank;
import java.util.List;

public record UpdateTrackDto(
    @NotBlank(message = "The field 'id' must not be blank.") String id,
    String refCode,
    Boolean isPublic,
    List<TagDto> tags,
    TrackDetailDto detail,
    List<TrackArtistDto> trackArtists) {}
