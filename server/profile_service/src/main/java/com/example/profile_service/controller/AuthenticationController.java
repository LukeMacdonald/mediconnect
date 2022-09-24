package com.example.profile_service.controller;

import com.example.profile_service.payload.JSTLLoginSuccessResponse;
import com.example.profile_service.payload.LoginRequest;
import com.example.profile_service.security.JwtTokenProvider;
import com.example.profile_service.service.MapValidationErrorService;
import com.example.profile_service.service.UserService;
import com.example.profile_service.validator.UserValidator;
import com.example.profile_service.model.Doctor;
import com.example.profile_service.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

import static com.example.profile_service.security.SecurityConstant.TOKEN_PREFIX;

@RestController
@RequiredArgsConstructor
@Slf4j
public class AuthenticationController {

    final private MapValidationErrorService mapValidationErrorService;

    final private UserService userService;

    final private UserValidator userValidator;


    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@Valid @RequestBody User user, BindingResult result) {

        // Validate passwords match
        userValidator.validate(user, result);

        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if (errorMap != null) return errorMap;

        User newUser = userService.saveUser(user);

        return new ResponseEntity<User>(newUser, HttpStatus.CREATED);
    }

    @PostMapping("/register/doctor")
    public ResponseEntity<?> registerDoctor(@Valid @RequestBody Doctor doctor, BindingResult result) {

        System.out.println(doctor.getRole().getRoleName());
        // Validate passwords match
        User newUser = new User(doctor.getEmail(),doctor.getPassword(),doctor.getRole().getRoleName(),
                doctor.getConfirmPassword());

        userValidator.validate(newUser, result);
        userValidator.validateDoctor(doctor, result);

        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if (errorMap != null) return errorMap;

        userService.saveUser(newUser);

        return new ResponseEntity<User>(newUser, HttpStatus.CREATED);
    }

    final private JwtTokenProvider tokenProvider;

    final private AuthenticationManager authenticationManager;

    @PostMapping("/login")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest, BindingResult result) {
        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if (errorMap != null) return errorMap;

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getEmail(),
                        loginRequest.getPassword()
                )
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = TOKEN_PREFIX + tokenProvider.generateToken(authentication);

        return ResponseEntity.ok(new JSTLLoginSuccessResponse(true, jwt));
    }
}
