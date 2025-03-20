package vn.io.echovibe.web.configuration;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import vn.io.echovibe.web.interceptor.JwtExtractorInterceptor;
import vn.io.echovibe.web.interceptor.RequestInfoInterceptor;

@Configuration
@Slf4j
@RequiredArgsConstructor
public class WebConfiguration implements WebMvcConfigurer {
  private final WebCorsConfiguration corsConfiguration;
  private final RequestInfoInterceptor requestInfoInterceptor;
  private final JwtExtractorInterceptor jwtExtractorInterceptor;

  @Override
  public void addCorsMappings(@NonNull CorsRegistry registry) {
    final String[] allowedOriginPatterns =
        Optional.ofNullable(corsConfiguration.getAllowedOriginPatterns())
            .orElse(List.of("*"))
            .toArray(String[]::new);
    final String[] allowedMethods =
        Optional.ofNullable(corsConfiguration.getAllowedMethods())
            .orElse(List.of("*"))
            .toArray(String[]::new);
    final String[] allowedHeaders =
        Optional.ofNullable(corsConfiguration.getAllowedHeaders())
            .orElse(List.of("*"))
            .toArray(String[]::new);
    final boolean allowCredentials =
        Optional.ofNullable(corsConfiguration.getAllowCredentials()).orElse(true);
    final long maxAge = Optional.ofNullable(corsConfiguration.getMaxAge()).orElse(0L);
    registry
        .addMapping("/**")
        .allowedOriginPatterns(allowedOriginPatterns)
        .allowedMethods(allowedMethods)
        .allowedHeaders(allowedHeaders)
        .allowCredentials(allowCredentials)
        .maxAge(maxAge);
    log.info(
        "Cross-origin resource sharing (CORS) configuration: allowedOriginPatterns=%s, allowedMethods=%s, allowedHeaders=%s, allowCredentials=%s, maxAge=%d"
            .formatted(
                Arrays.toString(allowedOriginPatterns),
                Arrays.toString(allowedMethods),
                Arrays.toString(allowedHeaders),
                allowCredentials,
                maxAge));
  }

  @Override
  public void addInterceptors(@NonNull InterceptorRegistry registry) {
    registry.addInterceptor(requestInfoInterceptor);
    registry.addInterceptor(jwtExtractorInterceptor);
  }
}
