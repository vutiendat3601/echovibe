package vn.io.echovibe.playlist.command.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.command.Command;
import vn.io.echovibe.playlist.common.model.PlaylistDetail;

@SuperBuilder
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdatePlaylistDetailCommand extends Command {
  private PlaylistDetail detail;
}
