package vn.io.echovibe.core.exception;

import vn.io.echovibe.core.model.BusinessRule;

public class BusinessRuleViolationException extends RuntimeException {
  private final BusinessRule businessRule;

  public BusinessRuleViolationException(BusinessRule businessRule) {
    super("%s".formatted(businessRule.message()));
    this.businessRule = businessRule;
  }

  public BusinessRuleViolationException(BusinessRule businessRule, String message) {
    super("%s\n%s".formatted(businessRule.message(), message));
    this.businessRule = businessRule;
  }

  public BusinessRule getBusinessRule() {
    return businessRule;
  }
}
