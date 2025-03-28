package vn.io.echovibe.artist.common.event;

import java.util.LinkedList;
import java.util.List;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.artist.common.model.ArtistProfile;
import vn.io.echovibe.artist.common.model.Tag;
import vn.io.echovibe.core.event.Event;

@NoArgsConstructor
@SuperBuilder
@Getter
@Setter
public class ArtistCreatedEvent extends Event {
  private String urn;

  private String refCode;

  private ArtistProfile profile;

  @Builder.Default private Integer revisionNumber = -1;

  @Builder.Default private Boolean isReleased = false;

  @Builder.Default private Boolean isPublic = false;

  @Builder.Default private Boolean isActive = true;

  @Builder.Default private List<Tag> tags = new LinkedList<>();

  @Builder.Default private Boolean isVerified = false;

  {
    type = getClass().getSimpleName();
  }
}
