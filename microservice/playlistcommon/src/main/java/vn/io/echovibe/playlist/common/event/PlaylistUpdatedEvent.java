package vn.io.echovibe.playlist.common.event;

import lombok.AllArgsConstructor;
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
public class PlaylistUpdatedEvent extends Event {
  private String name;

  private String thumbnailUrl;

  private String refCode;
}
