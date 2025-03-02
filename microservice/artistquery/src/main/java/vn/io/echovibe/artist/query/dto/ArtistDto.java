package vn.io.echovibe.artist.query.dto;

import java.util.ArrayList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.dto.QueryDto;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ArtistDto extends QueryDto {
  private String id;

  private String urn;

  private String name;

  @Builder.Default private Boolean isPublic = true;

  private String description;

  private String thumbnailUrl;

  private String backgroundUrl;

  @Builder.Default private List<String> tags = new ArrayList<>();

  private String ref;
}
