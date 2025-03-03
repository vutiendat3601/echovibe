package vn.io.echovibe.artist.common.event;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.event.Event;

@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Getter
@Setter
public class ArtistUpdatedEvent extends Event {
  private String name;

  private String biography;

  private String description;

  private String thumbnailUrl;

  private String backgroundUrl;

  private String refCode;
}
