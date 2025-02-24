package vn.io.echovibe.core.query;

import java.util.List;
import org.springframework.lang.NonNull;
import vn.io.echovibe.core.dto.QueryDto;

@FunctionalInterface
public interface QueryHandlerFunction<T extends Query> {
  @NonNull
  List<QueryDto> handle(@NonNull T query);
}
