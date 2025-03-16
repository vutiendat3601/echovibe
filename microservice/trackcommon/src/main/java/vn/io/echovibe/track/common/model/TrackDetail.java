package vn.io.echovibe.track.common.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TrackDetail {
  private String name;

  private String description;

  private String thumbnailFileKey;

  private String thumbnailUrl;

  private String refCode;
}
