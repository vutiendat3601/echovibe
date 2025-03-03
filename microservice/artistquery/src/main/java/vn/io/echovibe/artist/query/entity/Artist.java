package vn.io.echovibe.artist.query.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.hibernate.annotations.Type;

import io.hypersistence.utils.hibernate.type.array.ListArrayType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import vn.io.echovibe.core.entity.AuditEntity;

@SuperBuilder
@Entity
@Table(name = "artist")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Artist extends AuditEntity {
  @Id
  @GeneratedValue(generator = "pg-uuid")
  @Column(name = "id", nullable = false, updatable = false)
  private UUID id;

  @Column(name = "aggregate_id", nullable = false, updatable = false, unique = true)
  private String aggregateId;

  @Column(name = "urn", nullable = false, updatable = false, unique = true)
  private String urn;

  @Column(name = "name", nullable = false)
  private String name;

  @Column(name = "market", nullable = false)
  private String market;

  @Column(name = "biography", nullable = false)
  private String biography;

  @Column(name = "description")
  private String description;

  @Builder.Default
  @Column(name = "is_public", nullable = false)
  private Boolean isPublic = false;

  @Builder.Default
  @Column(name = "is_published", nullable = false)
  private Boolean isPublished = false;

  @Builder.Default
  @Column(name = "is_active", nullable = false)
  private Boolean isActive = true;

  @Column(name = "thumbnail_file_key")
  private String thumbnailFileKey;

  @Column(name = "thumbnail_url")
  private String thumbnailUrl;

  @Column(name = "background_file_key")
  private String backgroundFileKey;

  @Column(name = "background_url")
  private String backgroundUrl;

  @Builder.Default
  @Column(name = "tags", nullable = false)
  @Type(ListArrayType.class)
  private List<String> tags = new ArrayList<>();

  @Column(name = "ref_code", updatable = false, unique = true)
  private String refCode;
}
