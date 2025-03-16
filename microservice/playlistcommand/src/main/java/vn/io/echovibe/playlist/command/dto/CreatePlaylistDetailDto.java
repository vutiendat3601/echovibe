package vn.io.echovibe.playlist.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import vn.io.echovibe.core.annotation.NullOrNotBlank;

public record CreatePlaylistDetailDto(
    @NotBlank(message = "The field 'name' must not be null or blank.") String name,
    @NullOrNotBlank(message = "The field 'description' must not be blank.") String description,
    @Pattern(regexp = URL_REGEX, message = "The field 'thumbnailUrl' must be a valid URL format")
        String thumbnailUrl,
    @NullOrNotBlank(message = "The field 'refCode' must not be blank.") String refCode) {}
