package vn.io.echovibe.track.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record UpdateTrackDetailDto(
    @NotBlank(message = "The field 'id' must not be blank.") String id,
    String name,
    String biography,
    String description,
    @Pattern(regexp = URL_REGEX, message = "The field 'thumbnailUrl' must be a valid URL format")
        String thumbnailUrl,
    String refCode) {}
