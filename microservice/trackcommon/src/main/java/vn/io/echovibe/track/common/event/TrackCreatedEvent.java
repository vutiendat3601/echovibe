package vn.io.echovibe.track.common.event;

import java.util.LinkedList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
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
public class TrackCreatedEvent extends Event {
  private String urn;

  private TrackDetail detail;

  @Builder.Default private Boolean isReleased = false;

  @Builder.Default private Boolean isPublic = false;

  @Builder.Default private Boolean isActive = true;

  @Builder.Default private Integer revisionNumber = -1;

  private String refCode;

  @Builder.Default private List<Tag> tags = new LinkedList<>();

  @Builder.Default private List<TrackArtist> trackArtists = new LinkedList<>();

  {
    type = getClass().getSimpleName();
  }
}
