package vn.io.echovibe.playlist.command.dto;

import static vn.io.echovibe.core.constant.Constant.URL_REGEX;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import java.util.List;
import vn.io.echovibe.core.annotation.NullOrNotBlank;

public record CreatePlaylistDto(
    @NotBlank(message = "Field 'name' field must not be null or blank.") String name,
    String description,
    @Pattern(regexp = URL_REGEX, message = "Field 'thumbnailUrl' must be a valid URL format")
        String thumbnailUrl,
    @NullOrNotBlank(message = "Field 'refCode' field must not be blank.") String refCode,
    List<String> artistIds) {}
