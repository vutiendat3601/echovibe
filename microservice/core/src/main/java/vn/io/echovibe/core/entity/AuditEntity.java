package vn.io.echovibe.core.entity;

import jakarta.persistence.MappedSuperclass;
import java.time.ZonedDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@MappedSuperclass
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public abstract class AuditEntity {
  private String createdBy;

  private String updatedBy;

  private ZonedDateTime createdAt;

  private ZonedDateTime updatedAt;
}
