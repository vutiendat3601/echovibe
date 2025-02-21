package vn.io.echovibe.core.configuration;

import java.util.List;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "app.web.cors")
public class WebCorsConfiguration {
  private List<String> allowedOriginPatterns;

  private List<String> allowedMethods;

  private List<String> allowedHeaders;

  private String exposedHeaders;

  private Boolean allowCredentials = true;

  private Long maxAge;
}
