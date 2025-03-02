package vn.io.echovibe.core.constant;

public interface Constant {
  String AGGREGATE_APPLY_METHOD = "apply";
  String CORRELATION_ID_HEADER = "X-Correlation-ID";

  String AUTH_JWT_BEARER_PREFIX = "Bearer ";
  String AUTH_JWT_USERNAME_CLAIM = "preferred_username";
  String AUTH_SYSTEM_USERNAME = "system";

  String JPA_AUDIT_DATETIME_PROVIDER_BEAN = "dateTimeProvider";
  String REQUEST_PROCESSED_SUCCESS = "Request was processed successfully.";
}
