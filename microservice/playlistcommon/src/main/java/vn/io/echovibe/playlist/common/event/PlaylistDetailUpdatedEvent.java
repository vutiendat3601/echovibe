package vn.io.echovibe.playlist.common.event;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.playlist.common.model.PlaylistDetail;

@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Getter
@Setter
public class PlaylistDetailUpdatedEvent extends Event {
  private PlaylistDetail detail;
}
