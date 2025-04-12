package vn.io.echovibe.track.common.event;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.track.common.model.Tag;
import vn.io.echovibe.track.common.model.TrackArtist;
import vn.io.echovibe.track.common.model.TrackDetail;

@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Getter
@Setter
public class TrackUpdatedEvent extends Event {
  private TrackDetail detail;

  private String refCode;

  private Boolean isPublic;

  private List<Tag> tags;

  private List<TrackArtist> trackArtists;

  private Boolean isReleased;

  {
    type = getClass().getSimpleName();
  }
}
