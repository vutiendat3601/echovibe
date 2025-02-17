package vn.io.echovibe.core.domain;

import static vn.io.echovibe.core.constant.Constant.AGGREGATE_APPLY_METHOD;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import vn.io.echovibe.core.event.Event;

@Slf4j
@NoArgsConstructor
@AllArgsConstructor
public abstract class AggregateRoot {
  @Getter @Setter protected String id;

  @Getter @Setter private int version = -1;

  private final List<Event> changes = new ArrayList<>();

  public List<Event> getUncommittedChanges() {
    return this.changes;
  }

  public void markChangesAsCommitted() {
    this.changes.clear();
  }

  protected void applyChange(Event event, boolean isNewEvent) {
    try {
      final Method method = getClass().getDeclaredMethod(AGGREGATE_APPLY_METHOD, event.getClass());
      method.setAccessible(true);
      method.invoke(this, event);
    } catch (NoSuchMethodException e) {
      log.warn(
          "The apply method was not found in the aggregate root for {}",
          event.getClass().getName());
    } catch (Exception e) {
      log.error("Error applying event to aggregate", e);
    } finally {
      if (isNewEvent) {
        changes.add(event);
      }
    }
  }

  public void raiseEvent(Event event) {
    applyChange(event, true);
  }

  public void replayEvents(Iterable<Event> events) {
    events.forEach(event -> applyChange(event, false));
  }
}
