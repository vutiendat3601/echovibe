package vn.io.echovibe.track.command.model;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.command.Command;
import vn.io.echovibe.track.common.model.Tag;
import vn.io.echovibe.track.common.model.TrackArtist;
import vn.io.echovibe.track.common.model.TrackDetail;

@SuperBuilder
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateTrackCommand extends Command {
  private TrackDetail detail;

  private Boolean isPublic;

  private String refCode;

  private List<Tag> tags;

  private List<TrackArtist> trackArtists;
}
