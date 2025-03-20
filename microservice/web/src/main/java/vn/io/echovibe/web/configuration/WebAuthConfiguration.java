package vn.io.echovibe.web.configuration;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Getter
@Setter
@NoArgsConstructor
@Configuration
@ConfigurationProperties("app.web.auth")
public class WebAuthConfiguration {
  private String openIdConnectCertsUrl;
}
