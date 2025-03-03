package vn.io.echovibe.core.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import java.util.Locale;
import java.util.Objects;
import java.util.Set;
import vn.io.echovibe.core.annotation.NullOrNotBlank;

/***
 * Skip the validation when the value is null.
 **/
public class IsoCountryCodeValidator implements ConstraintValidator<NullOrNotBlank, String> {
  private final Set<String> ISO_COUNTRY_CODES = Set.of(Locale.getISOCountries());

  @Override
  public void initialize(NullOrNotBlank constraintAnnotation) {}

  @Override
  public boolean isValid(String value, ConstraintValidatorContext context) {
    if (Objects.nonNull(value)) {
      return ISO_COUNTRY_CODES.contains(value);
    }
    return true;
  }
}
