package vn.io.echovibe.track.common.event;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.event.Event;
import vn.io.echovibe.track.common.model.TrackAudio;

@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Getter
@Setter
public class TrackAudioMappedEvent extends Event {
  private TrackAudio trackAudio;

  @Builder.Default private Boolean isReleased = false;

  {
    type = getClass().getSimpleName();
  }
}
