package vn.io.echovibe.artist.command.dto;

import jakarta.validation.constraints.NotBlank;
import java.util.List;

public record UpdateArtistDto(
    @NotBlank(message = "The field 'id' must not be null or blank.") String id,
    String refCode,
    Boolean isPublic,
    List<TagDto> tags,
    ArtistProfileDto profile) {}
