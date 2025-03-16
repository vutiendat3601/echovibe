package vn.io.echovibe.track.command.model;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.command.Command;
import vn.io.echovibe.track.common.model.TrackDetail;

@SuperBuilder
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CreateTrackCommand extends Command {
  private TrackDetail detail;

  private List<String> artistIds;
}
