package vn.io.echovibe.track.common.event;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.event.Event;

@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Getter
@Setter
public class TrackDeletedEvent extends Event {
  @Builder.Default private Boolean isActive = false;

  @Builder.Default private Boolean isSoftDeleted = true;
}
