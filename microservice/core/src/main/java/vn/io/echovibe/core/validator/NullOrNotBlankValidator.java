package vn.io.echovibe.core.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import java.util.Objects;
import vn.io.echovibe.core.annotation.NullOrNotBlank;

public class NullOrNotBlankValidator implements ConstraintValidator<NullOrNotBlank, String> {

  public void initialize(NullOrNotBlank parameters) {}

  public boolean isValid(String value, ConstraintValidatorContext constraintValidatorContext) {
    return Objects.isNull(value) || value.trim().length() > 0;
  }
}
