package vn.io.echovibe.core.query;

import org.springframework.lang.NonNull;
import vn.io.echovibe.core.model.QueryResult;

public interface QueryDispatcher {
  <T extends Query> void registerHandler(
      @NonNull Class<T> type, @NonNull QueryHandlerFunction<T> queryhandler);

  QueryResult send(@NonNull Query query);
}
