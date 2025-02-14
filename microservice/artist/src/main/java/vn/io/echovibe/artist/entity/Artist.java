package vn.io.echovibe.artist.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.hibernate.annotations.Type;

import io.hypersistence.utils.hibernate.type.array.ListArrayType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import vn.io.echovibe.core.entity.AuditEntity;

@Builder
@Entity
@Table(name = "artist")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Artist extends AuditEntity {
  @Id
  @Column(name = "id", nullable = false, updatable = false)
  private UUID id;

  @Column(name = "urn", nullable = false, updatable = false)
  private String urn;

  @Column(name = "name", nullable = false)
  private String name;

  @Builder.Default
  @Column(name = "is_public", nullable = false)
  private Boolean isPublic = true;

  @Column(name = "description")
  private String description;

  @Column(name = "thumbnail_file_key")
  private String thumbnailFileKey;

  @Column(name = "background_file_key")
  private String backgroundFileKey;

  @Builder.Default
  @Column(name = "tags", nullable = false)
  @Type(ListArrayType.class)
  private List<String> tags = new ArrayList<>();

  @Column(name = "ref", updatable = false)
  private String ref;
}
