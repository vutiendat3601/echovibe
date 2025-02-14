package vn.io.echovibe.track.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import vn.io.echovibe.core.entity.AuditEntity;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "track")
public class Track extends AuditEntity {
  @Id
  @GeneratedValue(generator = "pg-uuid")
  @Column(name = "id", nullable = false, updatable = false)
  private UUID id;

  @Column(name = "urn", nullable = false, updatable = false)
  private String urn;

  @Column(name = "name", nullable = false)
  private String name;

  @Column(name = "thumbnail")
  private String thumbnail;

  @Column(name = "description")
  private String description;

  @Builder.Default
  @Column(name = "is_public", nullable = false)
  private Boolean isPublic = false;

  @Column(name = "duration_ms")
  private Integer durationMs;

  @Column(name = "released_date")
  private String releasedDate;

  @Builder.Default
  @OneToMany(mappedBy = "track", cascade = CascadeType.ALL)
  private List<TrackArtist> trackArtists = new ArrayList<>();
}
