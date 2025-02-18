package vn.io.echovibe.artist.command.event;

import java.util.UUID;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import vn.io.echovibe.core.event.Event;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class ArtistCreatedEvent implements Event {
  private String name;

  private Boolean isPublic;

  private String description;
}
