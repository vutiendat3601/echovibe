package vn.io.echovibe.track.common.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@Getter
@Setter
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class TrackArtist {
  private String artistId;

  private String artistRefCode;

  private Boolean isMainArtist;

  private Boolean isActive;
}
