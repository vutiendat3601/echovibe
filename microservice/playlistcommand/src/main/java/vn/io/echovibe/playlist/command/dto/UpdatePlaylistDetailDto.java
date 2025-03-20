package vn.io.echovibe.playlist.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record UpdatePlaylistDetailDto(
    @NotBlank(message = "The field 'id' must not be null or blank.") String id,
    String name,
    String biography,
    String description,
    @Pattern(regexp = URL_REGEX, message = "The field 'thumbnailUrl' must be a valid URL format")
        String thumbnailUrl,
    @Pattern(regexp = URL_REGEX, message = "The field 'backgroundUrl' must be a valid URL format")
        String backgroundUrl,
    String refCode) {}
