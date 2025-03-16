package vn.io.echovibe.artist.common.model;

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
public class ArtistProfile {
  private String name;

  private String biography;

  private String description;

  private String thumbnailFileKey;

  private String thumbnailUrl;

  private String backgroundFileKey;

  private String backgroundUrl;

  private String refCode;
}
