package vn.io.echovibe.artist.query.mapper;

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
        .name(artist.getName())
        .description(artist.getDescription())
        .isPublic(artist.getIsPublic())
        .build();
  }
}
