package vn.io.echovibe.core.exception;

import lombok.Getter;

@Getter
public class WebAuthenticationException extends RuntimeException {
  public WebAuthenticationException(String message) {
    super(message);
  }
}
