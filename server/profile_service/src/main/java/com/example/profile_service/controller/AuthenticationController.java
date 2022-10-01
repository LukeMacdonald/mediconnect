package com.example.profile_service.controller;

import com.example.profile_service.model.Verification;
import com.example.profile_service.repository.VerificationRepo;
import com.example.profile_service.service.MapValidationErrorService;
import com.example.profile_service.service.UserService;
import com.example.profile_service.validator.UserValidator;
import com.example.profile_service.model.Doctor;
import com.example.profile_service.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class AuthenticationController {

    final private MapValidationErrorService mapValidationErrorService;

    final private VerificationRepo verificationRepo;

    final private UserService userService;

    final private UserValidator userValidator;

    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid @RequestBody User user, BindingResult result) {

        // Validate passwords match
        userValidator.validate(user, result);

        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if (errorMap != null) return errorMap;

        User newUser = userService.saveUser(user);

        return new ResponseEntity<>(newUser, HttpStatus.CREATED);
    }

    @PostMapping("/register/doctor")
    public ResponseEntity<?> doctorRegister(@Valid @RequestBody Doctor doctor, BindingResult result) {

        // Validate passwords match
        User newUser = new User(doctor.getEmail(),doctor.getPassword(),doctor.getRole().getRoleName(),
                doctor.getConfirmPassword());

        userValidator.validate(newUser, result);
        userValidator.validateDoctor(doctor, result);

        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if (errorMap != null) return errorMap;

        userService.saveUser(newUser);

        return new ResponseEntity<>(newUser, HttpStatus.CREATED);
    }
    // Check Verification Table for email existing
    @GetMapping(value ="admin/add/doctor/verification/{email}")
    public ResponseEntity<?>  doctorVerification(@PathVariable("email") String email){

        Map<String, Object> response = new HashMap<>();

        if(verificationRepo.existsByEmail(email)){
            response.put("error","Code Already Sent");
            return new ResponseEntity<>(response, HttpStatus.CONFLICT);
        }

        Verification verification = new Verification(email);
        userService.saveCode(verification);
        response.put("email", verification.getEmail());
        response.put("code", verification.getCode());

        return new ResponseEntity<>(response, HttpStatus.CREATED);

    }
}
