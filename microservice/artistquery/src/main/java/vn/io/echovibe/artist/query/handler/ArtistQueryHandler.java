package vn.io.echovibe.artist.query.handler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import vn.io.echovibe.artist.query.dao.ArtistDao;
import vn.io.echovibe.artist.query.dto.ArtistDto;
import vn.io.echovibe.artist.query.mapper.ArtistDtoMapper;
import vn.io.echovibe.artist.query.model.FindArtistByIdQuery;
import vn.io.echovibe.artist.query.model.FindArtistByIdsQuery;
import vn.io.echovibe.artist.query.model.FindArtistPageQuery;
import vn.io.echovibe.core.model.ListQueryResult;
import vn.io.echovibe.core.model.PageQueryResult;
import vn.io.echovibe.core.model.QueryResult;

@RequiredArgsConstructor
@Service
public class ArtistQueryHandler implements QueryHandler {
  private final ArtistDtoMapper artistDtoMapper;
  private final ArtistDao artistDao;

  @Override
  @NonNull
  public QueryResult handle(@NonNull FindArtistByIdQuery findArtistByIdQuery) {
    final ListQueryResult<ArtistDto> queryResult = new ListQueryResult<>();
    artistDao
        .selectArtistByAggregateIdAndIsActiveTrue(findArtistByIdQuery.getId())
        .map(artistDtoMapper)
        .ifPresent(queryResult::add);
    return queryResult;
  }

  @Override
  @NonNull
  public QueryResult handle(@NonNull FindArtistPageQuery findArtistPageQuery) {
    final PageQueryResult<ArtistDto> queryResult = new PageQueryResult<>();
    final Page<ArtistDto> artistDtoPage =
        artistDao
            .selectByIsActiveTrueOrderByUpdatedAt(
                findArtistPageQuery.getPage(), findArtistPageQuery.getSize())
            .map(artistDtoMapper);
    queryResult.setItems(artistDtoPage.getContent());
    queryResult.setPage(artistDtoPage.getNumber());
    queryResult.setSize(artistDtoPage.getSize());
    queryResult.setTotalItems(artistDtoPage.getTotalElements());
    queryResult.setTotalPages(artistDtoPage.getTotalPages());
    return queryResult;
  }

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
