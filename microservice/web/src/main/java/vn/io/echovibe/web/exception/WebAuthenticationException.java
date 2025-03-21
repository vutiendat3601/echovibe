package vn.io.echovibe.web.exception;

import lombok.Getter;

@Getter
public class WebAuthenticationException extends RuntimeException {
  public WebAuthenticationException(String message) {
    super(message);
  }
}
