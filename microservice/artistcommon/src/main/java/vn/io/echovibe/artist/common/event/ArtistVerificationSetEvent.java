package vn.io.echovibe.artist.common.event;

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
public class ArtistVerificationSetEvent extends Event {
  private Boolean isVerified;

  @Builder.Default private Boolean isReleased = false;

  {
    type = getClass().getSimpleName();
  }
}
