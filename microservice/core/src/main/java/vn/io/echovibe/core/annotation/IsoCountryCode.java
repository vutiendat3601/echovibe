package vn.io.echovibe.core.annotation;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import vn.io.echovibe.core.validator.IsoCountryCodeValidator;

/***
 * Skip the validation when the value is null.
 **/
@Target({FIELD, PARAMETER})
@Retention(RUNTIME)
@Documented
@Constraint(validatedBy = IsoCountryCodeValidator.class)
public @interface IsoCountryCode {
  String message() default "must match ISO 3166-1 Alpha-2 Country Code";

  Class<?>[] groups() default {};

  Class<? extends Payload>[] payload() default {};
}
