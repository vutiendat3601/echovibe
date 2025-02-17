package vn.io.echovibe.core.utils;

import java.util.UUID;

public interface IdentityUtils {
  static String generateAggregateId() {
    return UUID.randomUUID().toString();
  }
}
