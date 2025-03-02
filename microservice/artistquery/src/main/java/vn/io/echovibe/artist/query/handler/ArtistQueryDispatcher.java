package vn.io.echovibe.artist.query.handler;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import vn.io.echovibe.core.exception.CommandHandlerFunctionNotFound;
import vn.io.echovibe.core.model.QueryResult;
import vn.io.echovibe.core.query.Query;
import vn.io.echovibe.core.query.QueryDispatcher;
import vn.io.echovibe.core.query.QueryHandlerFunction;

@SuppressWarnings({"rawtypes", "unchecked"})
@Service
public class ArtistQueryDispatcher implements QueryDispatcher {
  private final Map<Class<? extends Query>, QueryHandlerFunction> handlerMap = new HashMap<>();

  @SuppressWarnings("static-access")
  @Override
  public QueryResult send(@NonNull Query query) {
    final Class<? extends Query> commandClass = query.getClass();
    final QueryHandlerFunction queryHandlerFunction = handlerMap.get(commandClass);
    if (Objects.isNull(queryHandlerFunction)) {
      throw new CommandHandlerFunctionNotFound(
          "Query hanlder function not found: queryType=%s".format(commandClass.getSimpleName()));
    }
    return queryHandlerFunction.handle(query);
  }

  @Override
  public <T extends Query> void registerHandler(
      @NonNull Class<T> type, @NonNull QueryHandlerFunction<T> queryHandlerFunction) {
    handlerMap.put(type, queryHandlerFunction);
  }
}
