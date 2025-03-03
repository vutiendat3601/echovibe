package vn.io.echovibe.artist.query.dto;

import java.time.Instant;
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

  private String market;

  private String biography;

  private String description;

  @Builder.Default private Boolean isPublic = true;

  @Builder.Default private Boolean isPublished = false;

  private String thumbnailUrl;

  private String backgroundUrl;

  @Builder.Default private List<String> tags = new ArrayList<>();

  private String refCode;

  private String createdBy;

  private String updatedBy;

  private Instant createdAt;

  private Instant updatedAt;
}
