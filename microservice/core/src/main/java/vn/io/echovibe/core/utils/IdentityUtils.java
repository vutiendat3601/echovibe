package vn.io.echovibe.core.utils;

import java.util.Random;

public interface IdentityUtils {
  String IDENTITY_CHARACTERS = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789";
  String AGGREGATE_ID_REGEX = "^[A-Za-z0-9]+$";
  int AGGREGATE_ID_LENGTH = 8;

  static String generateAggregateId() {
    final StringBuilder aggregateIdStrBuilder = new StringBuilder();
    final Random random = new Random();
    for (int i = 0; i < AGGREGATE_ID_LENGTH; i++) {
      aggregateIdStrBuilder.append(
          IDENTITY_CHARACTERS.charAt(random.nextInt(IDENTITY_CHARACTERS.length())));
    }
    return aggregateIdStrBuilder.toString();
  }
}
