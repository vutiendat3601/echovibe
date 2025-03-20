package vn.io.echovibe.core.util;

import java.util.Random;

public interface IdentityUtils {
  String IDENTITY_FIRST_CHARACTERS = "abcdefghijklmnopqrstuvwxyz";
  String IDENTITY_CHARACTERS =
      "abcdefghijklmnopqrstuvwxyzAaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789abcdefghijklmnopqrstuvwxyz";
  String AGGREGATE_ID_REGEX = "^[A-Za-z0-9]+$";
  int AGGREGATE_ID_LENGTH = 12;

  static String generateAggregateId() {
    final StringBuilder aggregateIdStrBuilder = new StringBuilder();
    final Random random = new Random();
    aggregateIdStrBuilder.append(
        IDENTITY_FIRST_CHARACTERS.charAt(random.nextInt(IDENTITY_FIRST_CHARACTERS.length())));
    for (int i = 1; i < AGGREGATE_ID_LENGTH; i++) {
      aggregateIdStrBuilder.append(
          IDENTITY_CHARACTERS.charAt(random.nextInt(IDENTITY_CHARACTERS.length())));
    }
    return aggregateIdStrBuilder.toString();
  }
}
