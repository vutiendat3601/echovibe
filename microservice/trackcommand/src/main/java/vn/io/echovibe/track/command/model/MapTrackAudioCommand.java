package vn.io.echovibe.track.command.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.command.Command;
import vn.io.echovibe.track.common.model.TrackAudio;

@SuperBuilder
@ToString
@Getter
@Setter
@NoArgsConstructor
public class MapTrackAudioCommand extends Command {
  private TrackAudio trackAudio;
}
