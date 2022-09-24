package com.example.profile_service.validator;

import com.example.profile_service.model.Verification;
import com.example.profile_service.repository.UserRepo;
import com.example.profile_service.repository.VerificationRepo;
import com.example.profile_service.model.Doctor;
import com.example.profile_service.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
@RequiredArgsConstructor
public class UserValidator implements Validator {

    final private VerificationRepo verificationRepo;
    final private UserRepo userRepo;

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object object, Errors errors) {

        User user = (User) object;
        if(userRepo.existsByEmail(user.getEmail())){
            errors.rejectValue("email","Exists", "Email must be unique");
        }
        if(user.getPassword().length() < 6){
            errors.rejectValue("password","Length", "Password must be at least 6 characters");
        }
        if(!user.getPassword().equals(user.getConfirmPassword())){
            errors.rejectValue("confirmPassword","Match", "Passwords must match");
        }
    }
    public void validateDoctor(Object object, Errors errors){
        Doctor doctor = (Doctor) object;

        Verification verification = verificationRepo.findByEmail(doctor.getEmail());
        if(verification == null){
            errors.rejectValue("email","Authorised", "Unauthorised");
        }
        else{
            if (doctor.getCode() != verification.getCode()){
                errors.rejectValue("code","Match", "Codes must match");
            }
        }
    }
}
