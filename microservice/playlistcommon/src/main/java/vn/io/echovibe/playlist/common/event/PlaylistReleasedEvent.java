package vn.io.echovibe.playlist.common.event;

import java.util.LinkedList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
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
public class PlaylistReleasedEvent extends Event {
  private String urn;

  private PlaylistDetail detail;

  @Builder.Default private Boolean isReleased = true;

  @Builder.Default private Boolean isPublic = false;

  @Builder.Default private List<String> tags = new LinkedList<>();
}
