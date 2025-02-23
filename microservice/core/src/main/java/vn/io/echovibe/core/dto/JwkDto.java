package vn.io.echovibe.core.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public record JwkDto(
    String kid,
    String kty,
    String alg,
    String use,
    List<String> x5c,
    String x5t,
    @JsonProperty("x5t#S256") String x5tS256,
    String n,
    String e) {}
