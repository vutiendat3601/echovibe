package vn.io.echovibe.playlist.command.model;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.command.Command;

@SuperBuilder
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CreatePlaylistCommand extends Command {
  private String name;

  private String description;

  private String thumbnailUrl;

  private List<String> artistIds;

  private String refCode;
}
