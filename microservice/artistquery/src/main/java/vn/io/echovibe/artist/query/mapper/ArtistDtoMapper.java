package vn.io.echovibe.artist.query.mapper;

import java.util.Optional;
import java.util.function.Function;
import org.springframework.stereotype.Component;
import vn.io.echovibe.artist.query.dto.ArtistDto;
import vn.io.echovibe.artist.query.entity.Artist;

@Component
public class ArtistDtoMapper implements Function<Artist, ArtistDto> {
  @Override
  public ArtistDto apply(Artist artist) {
    return ArtistDto.builder()
        .id(artist.getAggregateId())
        .urn(artist.getUrn())
        .name(artist.getName())
        .biography(artist.getBiography())
        .description(artist.getDescription())
        .isPublic(artist.getIsPublic())
        .isPublished(artist.getIsPublished())
        .thumbnailUrl(
            Optional.ofNullable(artist.getThumbnailUrl())
                .orElseGet(() -> artist.getThumbnailFileKey()))
        .backgroundUrl(
            Optional.ofNullable(artist.getBackgroundUrl())
                .orElseGet(() -> artist.getBackgroundFileKey()))
        .refCode(artist.getRefCode())
        .tags(artist.getTags())
        .createdBy(artist.getCreatedBy())
        .updatedBy(artist.getUpdatedBy())
        .createdAt(artist.getCreatedAt())
        .updatedAt(artist.getUpdatedAt())
        .build();
  }
}
