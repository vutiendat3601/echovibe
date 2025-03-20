package vn.io.echovibe.client.configuration;

import feign.Contract;
import feign.RequestInterceptor;
import org.springframework.cloud.openfeign.support.SpringMvcContract;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import vn.io.echovibe.client.interceptor.JwtRequestInterceptor;

@Configuration
public class WebClientConfiguration {
  @Bean
  Contract feignContract() {
    return new SpringMvcContract();
  }

  @Bean
  RequestInterceptor jwtClientRequestInterceptor() {
    return new JwtRequestInterceptor();
  }
}
