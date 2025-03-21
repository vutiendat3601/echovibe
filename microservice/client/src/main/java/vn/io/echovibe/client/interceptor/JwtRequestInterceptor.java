package vn.io.echovibe.client.interceptor;

import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.springframework.http.HttpHeaders;
import vn.io.echovibe.web.context.JwtSecurityHolder;

public class JwtRequestInterceptor implements RequestInterceptor {
  @Override
  public void apply(RequestTemplate template) {
    template.header(HttpHeaders.AUTHORIZATION, "Bearer " + JwtSecurityHolder.getJwt());
  }
}
