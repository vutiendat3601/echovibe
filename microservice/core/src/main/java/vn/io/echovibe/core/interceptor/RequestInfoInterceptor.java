package vn.io.echovibe.core.interceptor;

import static vn.io.echovibe.core.constant.Constant.AUTH_CONTEXT_HEADER;
import static vn.io.echovibe.core.constant.Constant.CORRELATION_ID_HEADER;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Slf4j
@Component
public class RequestInfoInterceptor implements HandlerInterceptor {
  @Override
  public boolean preHandle(
      @NonNull HttpServletRequest request,
      @NonNull HttpServletResponse response,
      @NonNull Object handler)
      throws Exception {
    final String correlationId = request.getHeader(CORRELATION_ID_HEADER);
    final String path = request.getServletPath();
    final String authContext = request.getHeader(AUTH_CONTEXT_HEADER);
    log.info(
        "Request Info: %s=%s,Path=%s,AuthContext=%s"
            .formatted(CORRELATION_ID_HEADER, correlationId, path, authContext));
    return true;
  }
}
