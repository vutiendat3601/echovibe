package vn.io.echovibe.core.model;

import java.util.LinkedList;
import java.util.List;
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
public class ListQueryResult<T> extends QueryResult {
  @Builder.Default protected List<T> items = new LinkedList<>();

  public void add(T item) {
    items.add(item);
  }
}
