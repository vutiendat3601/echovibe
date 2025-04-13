package vn.io.echovibe.track.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.validation.constraints.Pattern;

public record TrackDetailDto(
    String name,
    String description,
    @Pattern(regexp = "^\\d{4}(-\\d{2}(-\\d{2})?)?$") String officialReleasedDate,
    @Pattern(regexp = URL_REGEX, message = "The field 'thumbnailUrl' must be a valid URL format")
        String thumbnailUrl) {}
