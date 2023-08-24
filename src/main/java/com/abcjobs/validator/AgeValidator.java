package com.abcjobs.validator;

import com.abcjobs.annotation.AgeConstraint;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.Date;

public class AgeValidator implements ConstraintValidator<AgeConstraint, Date> {
    private static final int MIN_AGE = 3;
    private static final int MAX_AGE = 130; // Maximum age set as 130 years in this example.

    @Override
    public void initialize(AgeConstraint constraintAnnotation) {}

    @Override
    public boolean isValid(Date value, ConstraintValidatorContext context) {
        if (value == null) {
            return true; // Let other validators handle this case
        }

        Date currentDate = new Date();
        int age = (int) ((currentDate.getTime() - value.getTime()) / (1000 * 60 * 60 * 24 * 365L));
        return age >= MIN_AGE && age <= MAX_AGE;
    }
}
