package vn.io.echovibe.artist.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record CreateArtistDto(
    @NotBlank(message = "The 'name' field is required and must not be blank.") String name,
    @Nullable @NotBlank(message = "The 'biography' field is required and must not be blank.")
        String biography,
    @Nullable @NotBlank(message = "The 'description' field is required and must not be blank.")
        String description,
    @Nullable @Pattern(regexp = URL_REGEX) String thumbnailUrl,
    @Nullable @Pattern(regexp = URL_REGEX) String backgroundUrl) {}
