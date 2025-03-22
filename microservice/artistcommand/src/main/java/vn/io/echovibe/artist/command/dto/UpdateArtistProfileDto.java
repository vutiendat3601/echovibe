package vn.io.echovibe.artist.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import org.hibernate.validator.constraints.Length;

public record UpdateArtistProfileDto(
    @NotBlank(message = "The field 'id' must not be null or blank.") String id,
    String name,
    @Length(max = 250, message = "The field 'description' must not exceed 250 characters.")
        String description,
    String biography,
    @Pattern(regexp = URL_REGEX, message = "The field 'thumbnailUrl' must be a valid URL format")
        String thumbnailUrl,
    @Pattern(regexp = URL_REGEX, message = "The field 'backgroundUrl' must be a valid URL format")
        String backgroundUrl) {}
