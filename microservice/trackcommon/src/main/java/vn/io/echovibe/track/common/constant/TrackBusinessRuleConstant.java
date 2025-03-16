package vn.io.echovibe.track.common.constant;

import vn.io.echovibe.core.model.BusinessRule;

public interface TrackBusinessRuleConstant {
  BusinessRule TRACK_BR_01 = new BusinessRule("BR-TRACK-01", "The track cannot be released again once it has been successfully released.");
}
