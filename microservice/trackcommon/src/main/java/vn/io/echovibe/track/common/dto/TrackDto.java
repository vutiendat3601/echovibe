package vn.io.echovibe.track.common.dto;

import java.time.ZonedDateTime;
import java.util.List;
import vn.io.echovibe.track.common.model.Tag;
import vn.io.echovibe.track.common.model.TrackDetail;

public record TrackDto(
    String id,
    String urn,
    String refCode,
    TrackDetail detail,
    String isPublic,
    List<Tag> tags,
    ZonedDateTime createdAt,
    ZonedDateTime updatedAt) {}
