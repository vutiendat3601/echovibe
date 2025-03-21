package vn.io.echovibe.artist.common.constant;

import vn.io.echovibe.core.model.BusinessRule;

public interface ArtistBussinessRuleConstant {
  BusinessRule ARTIST_BR_01 =
      new BusinessRule(
          "BR-ARTIST-01",
          "The artist cannot be released again once it has been successfully released.");
  BusinessRule ARTIST_BR_02 =
      new BusinessRule("BR-ARTIST-02", "Each artist has a unique reference code.");
}
