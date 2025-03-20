package vn.io.echovibe.web.context;

import static vn.io.echovibe.web.constant.WebConstant.AUTH_JWT_USERNAME_CLAIM;

import com.nimbusds.jwt.JWT;
import java.text.ParseException;
import java.util.Objects;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.NonNull;

@Slf4j
@Getter
@Setter
public class JwtSecurityHolder {
  private static final ThreadLocal<JWT> jwtHolder = new ThreadLocal<>();

  public static void setJwt(@NonNull JWT jwt) {
    jwtHolder.set(jwt);
  }

  public static JWT getJwt() {
    return jwtHolder.get();
  }

  public static String getSubject() {
    final JWT jwt = jwtHolder.get();
    if (Objects.nonNull(jwt)) {
      try {
        return jwt.getJWTClaimsSet().getSubject();
      } catch (ParseException e) {
        log.warn("Parse JWT claims error", e);
      }
    }
    return null;
  }

  public static String getUsername() {
    final JWT jwt = jwtHolder.get();
    if (Objects.nonNull(jwt)) {
      try {
        return jwt.getJWTClaimsSet().getClaimAsString(AUTH_JWT_USERNAME_CLAIM);
      } catch (ParseException e) {
        log.warn("Parse JWT claims error", e);
      }
    }
    return null;
  }
}
