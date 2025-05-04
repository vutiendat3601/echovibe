package vn.io.echovibe.track.common.constant;

import vn.io.echovibe.core.model.BusinessRule;

public interface TrackBusinessRuleConstant {
  BusinessRule TRACK_BR_01 =
      new BusinessRule(
          "BR-TRACK-01",
          "The track cannot be released again once it has been successfully released.");
  BusinessRule TRACK_BR_02 =
      new BusinessRule("BR-TRACK-02", "Each track has a unique reference code.");
  BusinessRule TRACK_BR_03 =
      new BusinessRule(
          "BR-TRACK-03",
          "The 'refCode' cannot be changed once it has been released at least once.");
  BusinessRule TRACK_BR_04 =
      new BusinessRule(
          "BR-TRACK-04", "Track Audio must inclues at least audioFileKey or fileM3u8Url.");
}
