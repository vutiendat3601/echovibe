package vn.io.echovibe.core.configuration;

import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import vn.io.echovibe.core.interceptor.RequestInfoInterceptor;

@Component
@RequiredArgsConstructor
public class WebInterceptorConfiguration implements WebMvcConfigurer {
  private final RequestInfoInterceptor requestInfoInterceptor;

  @Override
  public void addInterceptors(@NonNull InterceptorRegistry registry) {
    registry.addInterceptor(requestInfoInterceptor);
  }
}
