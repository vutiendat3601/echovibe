package vn.io.echovibe.artist.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record UpdateArtistDto(
    @NotBlank(message = "The 'id' field must not be blank.") String id,
    @Nullable @NotBlank(message = "The 'name' field must not be blank.") String name,
    @Nullable @NotBlank(message = "The 'biography' field must not be blank.") String biography,
    @Nullable @NotBlank(message = "The 'description' field must not be blank.") String description,
    @Nullable @Pattern(regexp = URL_REGEX) String thumbnailUrl,
    @Nullable @Pattern(regexp = URL_REGEX) String backgroundUrl) {}
