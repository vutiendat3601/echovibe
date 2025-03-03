package vn.io.echovibe.artist.query.handler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import vn.io.echovibe.artist.query.dao.ArtistDao;
import vn.io.echovibe.artist.query.dto.ArtistDto;
import vn.io.echovibe.artist.query.mapper.ArtistDtoMapper;
import vn.io.echovibe.artist.query.model.FindArtistByIdsQuery;
import vn.io.echovibe.core.model.ListQueryResult;
import vn.io.echovibe.core.model.QueryResult;

@RequiredArgsConstructor
@Service
public class ArtistQueryHandler implements QueryHandler {
  private final ArtistDtoMapper artistDtoMapper;
  private final ArtistDao artistDao;

  @Override
  @NonNull
  public QueryResult handle(@NonNull FindArtistByIdsQuery findArtistByIdsQuery) {
    final ListQueryResult<ArtistDto> queryResult = new ListQueryResult<>();
    final Map<String, ArtistDto> artistDtos = new HashMap<>();
    final List<String> ids = findArtistByIdsQuery.getIds();
    ids.forEach(
        id -> {
          artistDtos.putIfAbsent(
              id,
              artistDao.selectArtistByAggregateIdAndIsActiveTrue(id).map(artistDtoMapper).get());
          queryResult.add(artistDtos.get(id));
        });
    return queryResult;
  }
}
