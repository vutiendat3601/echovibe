package vn.io.echovibe.playlist.common.constant;

import vn.io.echovibe.core.model.BusinessRule;

public interface PlaylistBusinessRuleConstant {
  BusinessRule PLAYLIST_BR_01 =
      new BusinessRule("BR-PLAYLIST-01", "The playlist cannot be released again once it has been successfully released.");
}
