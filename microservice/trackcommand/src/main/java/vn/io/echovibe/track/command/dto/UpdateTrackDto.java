package vn.io.echovibe.track.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import vn.io.echovibe.core.annotation.NullOrNotBlank;

public record UpdateTrackDto(
    @NotBlank(message = "Field 'id' field must not be blank.") String id,
    @NullOrNotBlank(message = "Field 'name' field must not be blank.") String name,
    @NullOrNotBlank(message = "Field 'biography' must not be blank.") String biography,
    @NullOrNotBlank(message = "Field 'description' field must not be blank.") String description,
    @Pattern(regexp = URL_REGEX, message = "Field 'thumbnailUrl' must be a valid URL format")
        String thumbnailUrl,
    @Pattern(regexp = URL_REGEX, message = "Field 'backgroundUrl' must be a valid URL format")
        String backgroundUrl,
    @NullOrNotBlank(message = "Field 'refCode' field must not be blank.") String refCode) {}
