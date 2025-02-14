package vn.io.echovibe.artist.command;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateArtistCommand {
  private String name;

  private Boolean isPublic;

  private String description;

  private String thumbnail;

  private String background;
}
