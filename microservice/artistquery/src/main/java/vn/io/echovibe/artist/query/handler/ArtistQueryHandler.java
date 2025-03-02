package vn.io.echovibe.artist.query.handler;

import java.util.LinkedList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import vn.io.echovibe.artist.query.dao.ArtistDao;
import vn.io.echovibe.artist.query.mapper.ArtistDtoMapper;
import vn.io.echovibe.artist.query.model.FindArtistByIdQuery;
import vn.io.echovibe.core.dto.QueryDto;

@RequiredArgsConstructor
@Service
public class ArtistQueryHandler implements QueryHandler {
  private final ArtistDtoMapper artistDtoMapper;
  private final ArtistDao artistDao;

  @Override
  @NonNull
  public List<QueryDto> handle(@NonNull FindArtistByIdQuery findArtistByIdQuery) {
    final List<QueryDto> queryDtos = new LinkedList<>();
    artistDao
        .selectArtistByAggregateIdAndIsActiveTrue(findArtistByIdQuery.getId())
        .map(artistDtoMapper)
        .ifPresent(queryDtos::add);
    return queryDtos;
  }
}
