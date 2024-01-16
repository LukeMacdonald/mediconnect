package com.lukemacdonald.profileservice.validation;

import com.lukemacdonald.profileservice.model.Doctor;
import com.lukemacdonald.profileservice.model.User;
import com.lukemacdonald.profileservice.model.Verification;
import com.lukemacdonald.profileservice.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
@RequiredArgsConstructor
public class UserValidator implements Validator {

    final private UserService userService;

    int MIN_PASSWORD_LENGTH = 6;

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass) || Doctor.class.equals(aClass); // Make sure to support Doctor class
    }

    @Override
    public void validate(Object object, Errors errors) {
        if (object instanceof User) {
            validateUser((User) object, errors);
        } else if (object instanceof Doctor) {
            validateDoctor((Doctor) object, errors);
        }
    }

    private void validateUser(User user, Errors errors) {
        if (userService.existsByEmail(user.getEmail())) {
            errors.rejectValue("email", "Exists", "Email Already Exists!");
        }

        if (user.getPassword().length() < MIN_PASSWORD_LENGTH) {
            errors.rejectValue("password", "Length", "Password must be at least " + MIN_PASSWORD_LENGTH + " characters!");
        }

        if (!user.getPassword().equals(user.getConfirmPassword())) {
            errors.rejectValue("confirmPassword", "Match", "Passwords must match!");
        }
    }

    private void validateDoctor(Doctor doctor, Errors errors) {
        Verification verification = userService.findVerificationByEmail(doctor.getEmail());

        if (verification == null) {
            errors.rejectValue("email", "Authorised", "Unauthorised");
        } else {
            if (doctor.getCode() != verification.getCode()) {
                errors.rejectValue("code", "CodeMismatch", "Codes must match");
            }
        }
    }

    public void validateVerification(String email, Errors errors) {
        if (userService.verificationExistsByEmail(email)) {
            errors.rejectValue("email", "VerificationExists", "Verification already sent");
        }
    }
}


