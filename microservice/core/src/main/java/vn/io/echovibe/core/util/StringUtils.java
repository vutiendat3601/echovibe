package vn.io.echovibe.core.util;

import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;
import java.util.function.Supplier;

public interface StringUtils {
  final String ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  final Supplier<Map<Character, Character>> UNACCENT_CHARACTERS_MAP_SUPPLIER =
      () -> {
        final String CHARACTERS = "Đđ";
        final String UNACCENT_CHARACTERS = "Dd";
        final Map<Character, Character> result = new HashMap<>();
        for (int i = 0; i < CHARACTERS.length(); i++) {
          result.put(CHARACTERS.charAt(i), UNACCENT_CHARACTERS.charAt(i));
        }
        return result;
      };
  Map<Character, Character> UNACCENT_CHARACTERS_MAP = UNACCENT_CHARACTERS_MAP_SUPPLIER.get();

  public static String randomString(int length) {
    StringBuilder sb = new StringBuilder(length);
    for (int i = 0; i < length; i++) {
      int index = (int) (ALPHABET.length() * Math.random());
      sb.append(ALPHABET.charAt(index));
    }
    return sb.toString();
  }

  public static String removeAccent(String text) {
    if (Objects.isNull(text)) {
      throw new IllegalArgumentException("text argument must not be null.");
    }
    String result = Normalizer.normalize(text, Form.NFD).replaceAll("\\p{M}", "");
    for (Entry<Character, Character> cEntry : UNACCENT_CHARACTERS_MAP.entrySet()) {
      result = result.replace(cEntry.getKey(), cEntry.getValue());
    }
    return result.toString();
  }
}
