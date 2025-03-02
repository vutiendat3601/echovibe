package vn.io.echovibe.core.query;

import org.springframework.lang.NonNull;
import vn.io.echovibe.core.model.QueryResult;

@FunctionalInterface
public interface QueryHandlerFunction<T extends Query> {
  @NonNull
  QueryResult handle(@NonNull T query);
}
