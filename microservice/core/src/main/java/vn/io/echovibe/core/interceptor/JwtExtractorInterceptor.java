package vn.io.echovibe.core.interceptor;

import static vn.io.echovibe.core.constant.Constant.AUTH_JWT_BEARER_PREFIX;

import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSVerifier;
import com.nimbusds.jose.crypto.RSASSAVerifier;
import com.nimbusds.jose.jwk.JWK;
import com.nimbusds.jose.jwk.JWKSet;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jwt.JWT;
import com.nimbusds.jwt.JWTParser;
import com.nimbusds.jwt.SignedJWT;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import vn.io.echovibe.core.configuration.WebAuthConfiguration;
import vn.io.echovibe.core.context.JwtSecurityHolder;
import vn.io.echovibe.core.exception.WebAuthenticationException;

@Slf4j
@Component
public final class JwtExtractorInterceptor implements HandlerInterceptor {
  private final JWKSet jwkSet;
  private final Map<String, JWSVerifier> jwsVerifierMap;

  public JwtExtractorInterceptor(@NonNull WebAuthConfiguration webAuthConfiguration)
      throws MalformedURLException, IOException, ParseException {
    final String openIdConnectCertsUrl = webAuthConfiguration.getOpenIdConnectCertsUrl();
    log.info("OpenId Connect certsUrl: %s".formatted(openIdConnectCertsUrl));
    final URL jwksUrl = URI.create(openIdConnectCertsUrl).toURL();
    jwkSet = JWKSet.load(jwksUrl);
    jwsVerifierMap = new HashMap<>();
  }

  @Override
  public boolean preHandle(
      @NonNull HttpServletRequest request,
      @NonNull HttpServletResponse response,
      @NonNull Object handler)
      throws Exception {
    final String authorizationHeaderValue = request.getHeader(HttpHeaders.AUTHORIZATION);
    if (Objects.nonNull(authorizationHeaderValue)
        && authorizationHeaderValue.startsWith(AUTH_JWT_BEARER_PREFIX)) {
      final String jwtStr = authorizationHeaderValue.substring(AUTH_JWT_BEARER_PREFIX.length());
      final JWT jwt = JWTParser.parse(jwtStr);
      if (jwt instanceof SignedJWT signedJwt) {
        final String keyId = signedJwt.getHeader().getKeyID();
        final JWSVerifier jwsVerifier = getJwsVerifier(keyId);
        try {
          if (signedJwt.verify(jwsVerifier)) {
            JwtSecurityHolder.setJwt(signedJwt);
          }
        } catch (JOSEException e) {
          log.warn("Verify JWT error", e);
          throw new WebAuthenticationException("Forbidden, verify JWT error.");
        }
      }
    }
    return true;
  }

  private final JWSVerifier getJwsVerifier(@NonNull String keyId) {
    return Optional.ofNullable(
            jwsVerifierMap.computeIfAbsent(
                keyId,
                (k) -> {
                  final JWK jwk = jwkSet.getKeyByKeyId(keyId);
                  if (jwk instanceof RSAKey rsaKey) {
                    try {
                      return new RSASSAVerifier(rsaKey);
                    } catch (JOSEException e) {
                    }
                  }
                  return null;
                }))
        .orElseThrow(() -> new WebAuthenticationException("Forbidden, JWSVerifier not found."));
  }
}
