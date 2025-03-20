package vn.io.echovibe.core.constant;

import vn.io.echovibe.core.model.BusinessRule;

public interface BusinessRuleConstant {
  BusinessRule BR_01 =
      new BusinessRule("BR-01", "The update operation requires at least one field to be changed.");
}
