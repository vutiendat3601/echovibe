package vn.io.echovibe.artist.common.dto;

import java.util.List;
import vn.io.echovibe.artist.common.model.ArtistProfile;
import vn.io.echovibe.artist.common.model.Tag;

public record ArtistDto(
    String id,
    String urn,
    String refCode,
    ArtistProfile profile,
    String isPublic,
    List<Tag> tags) {}
