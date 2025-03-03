package vn.io.echovibe.artist.query.handler;

import org.springframework.lang.NonNull;
import vn.io.echovibe.artist.query.model.FindArtistByIdsQuery;
import vn.io.echovibe.core.model.QueryResult;

public interface QueryHandler {
  @NonNull
  QueryResult handle(@NonNull FindArtistByIdsQuery findArtistByIdQuery);
}
