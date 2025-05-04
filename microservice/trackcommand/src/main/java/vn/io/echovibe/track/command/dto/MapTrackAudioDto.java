package vn.io.echovibe.track.command.dto;

import jakarta.validation.constraints.NotNull;
import vn.io.echovibe.track.common.model.TrackAudio;

public record MapTrackAudioDto(
    @NotNull(message = "The field 'id' must not be null or blank.") String id,
    @NotNull(message = "The field 'trackAudio' must not be null.") TrackAudio trackAudio) {}
