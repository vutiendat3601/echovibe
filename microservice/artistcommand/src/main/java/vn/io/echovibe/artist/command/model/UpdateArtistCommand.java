package vn.io.echovibe.artist.command.model;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.artist.common.model.ArtistProfile;
import vn.io.echovibe.artist.common.model.Tag;
import vn.io.echovibe.core.command.Command;

@SuperBuilder
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateArtistCommand extends Command {
  private String refCode;

  private Boolean isPublic;

  private List<Tag> tags;

  private ArtistProfile profile;
}
