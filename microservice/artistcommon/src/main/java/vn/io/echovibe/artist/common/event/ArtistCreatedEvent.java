package vn.io.echovibe.artist.common.event;

import java.util.LinkedList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
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
public class ArtistCreatedEvent extends Event {
  private String urn;

  private String name;

  @Builder.Default private Boolean isPublic = false;

  private String description;

  @Builder.Default private Boolean isActive = true;

  @Builder.Default private Boolean isPublished = false;

  @Builder.Default private List<String> tags = new LinkedList<>();

  private String ref;
}
