package vn.io.echovibe.artist.query.handler;

import org.springframework.lang.NonNull;
import vn.io.echovibe.artist.query.model.FindArtistByIdQuery;
import vn.io.echovibe.artist.query.model.FindArtistPageQuery;
import vn.io.echovibe.core.model.QueryResult;

public interface QueryHandler {
  @NonNull
  QueryResult handle(@NonNull FindArtistByIdQuery findArtistByIdQuery);

  @NonNull
  QueryResult handle(@NonNull FindArtistPageQuery findArtistPageQuery);
}
