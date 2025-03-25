package vn.io.echovibe.artist.common.event;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.artist.common.model.ArtistProfile;
import vn.io.echovibe.core.event.Event;

@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Getter
@Setter
public class ArtistUpdatedEvent extends Event {
  private String refCode;

  private Boolean isPublic;

  private Boolean isReleased;

  private List<String> tags;

  private ArtistProfile profile;
}
