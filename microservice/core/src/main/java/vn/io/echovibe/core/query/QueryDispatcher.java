package vn.io.echovibe.core.query;

import java.util.List;
import org.springframework.lang.NonNull;
import vn.io.echovibe.core.dto.QueryDto;

public interface QueryDispatcher {
  <T extends Query> void registerHandler(
      @NonNull Class<T> type, @NonNull QueryHandlerFunction<T> queryhandler);

  <T extends QueryDto> List<T> send(@NonNull Query query);
}
