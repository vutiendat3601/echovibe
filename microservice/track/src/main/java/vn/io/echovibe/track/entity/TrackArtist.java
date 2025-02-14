package vn.io.echovibe.track.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
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
@Table(name = "track_artist")
public class TrackArtist extends AuditEntity {
  @Id
  @GeneratedValue(generator = "pg-uuid")
  @Column(name = "id", nullable = false, updatable = false)
  private UUID id;

  @ManyToOne
  @JoinColumn(name = "track_id")
  private Track track;

  @Column(name = "artist_id")
  private UUID artistId;

  @Builder.Default
  @Column(name = "is_main")
  private Boolean isMain = false;

  @Builder.Default
  @Column(name = "is_active")
  private Boolean isActive = true;
}
