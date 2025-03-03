package vn.io.echovibe.artist.command.model;

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
public class CreateArtistCommand extends Command {
  private String name;

  private String biography;

  private String description;

  private String thumbnailUrl;

  private String backgroundUrl;

  private String refCode;
}
