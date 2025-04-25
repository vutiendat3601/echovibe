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
public class TrackReleasedEvent extends Event {
  private String urn;

  private TrackDetail detail;

  @Builder.Default private Integer revisionNumber = -1;

  @Builder.Default private Boolean isReleased = true;

  @Builder.Default private Boolean isPublic = false;

  private String refCode;

  private String audioM3u8FileUrl;

  @Builder.Default private List<TrackArtist> trackArtists = new LinkedList<>();

  @Builder.Default private List<Tag> tags = new LinkedList<>();

  {
    type = getClass().getSimpleName();
  }
}
