package vn.io.echovibe.artist.query.handler;

import java.util.List;
import org.springframework.lang.NonNull;
import vn.io.echovibe.artist.query.model.FindArtistByIdQuery;
import vn.io.echovibe.core.dto.QueryDto;

public interface QueryHandler {
  @NonNull
  List<QueryDto> handle(@NonNull FindArtistByIdQuery findArtistByIdQuery);
}
