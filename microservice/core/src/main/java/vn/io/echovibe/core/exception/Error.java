package vn.io.echovibe.core.exception;

import vn.io.echovibe.core.model.BusinessRule;

public record Error(BusinessRule businessRule, String message, String object) {}
