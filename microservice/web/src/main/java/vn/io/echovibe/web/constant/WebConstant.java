package vn.io.echovibe.web.constant;

public interface WebConstant {
  String AUTH_JWT_BEARER_PREFIX = "Bearer ";
  String AUTH_JWT_USERNAME_CLAIM = "preferred_username";
  String CORRELATION_ID_HEADER = "X-Correlation-ID";
  String URL_REGEX =
      "(https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|www\\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9]+\\.[^\\s]{2,}|www\\.[a-zA-Z0-9]+\\.[^\\s]{2,})";
}
