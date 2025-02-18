package vn.io.echovibe.artist.dto;

import java.util.UUID;

public record CreateArtistDetailsDto(
    UUID id,
    String urn,
    String name,
    Boolean isPublic,
    String description,
    String thumbnail,
    String background) {}
