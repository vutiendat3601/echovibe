package vn.io.echovibe.artist.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import vn.io.echovibe.core.annotation.NullOrNotBlank;

public record CreateArtistProfileDto(
    @NotBlank(message = "The field 'name' must not be null or blank.") String name,
    @NullOrNotBlank(message = "The field 'biography' must not be blank.") String biography,
    @NullOrNotBlank(message = "The field 'description' must not be blank.") String description,
    @Pattern(regexp = URL_REGEX, message = "The field 'thumbnailUrl' must be a valid URL format")
        String thumbnailUrl,
    @Pattern(regexp = URL_REGEX, message = "The field 'backgroundUrl' must be a valid URL format")
        String backgroundUrl,
    @NullOrNotBlank(message = "The field 'refCode' must not be blank.") String refCode) {}
