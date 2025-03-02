package vn.io.echovibe.core.model;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Setter
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class PageQueryResult<T> extends QueryResult {

  private List<T> items;

  private Integer page;

  private Integer size;

  private Long totalItems;

  private Integer totalPages;

  @Setter(AccessLevel.NONE)
  @Builder.Default
  private Map<String, Object> query = new LinkedHashMap<>();

  public void addQuery(String key, Object value) {
    query.put(key, value);
  }
}
