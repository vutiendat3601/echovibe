package vn.io.echovibe.artist.common.event;

import java.util.LinkedList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
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
public class ArtistReleasedEvent extends Event {
  private String urn;

  private ArtistProfile profile;

  private Boolean isVerifed;

  private String refCode;

  private Integer revisionNumber;

  @Builder.Default private Boolean isReleased = true;

  @Builder.Default private Boolean isPublic = false;

  @Builder.Default private List<String> tags = new LinkedList<>();
}
