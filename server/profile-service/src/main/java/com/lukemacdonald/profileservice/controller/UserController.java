package com.lukemacdonald.profileservice.controller;

import com.lukemacdonald.profileservice.config.JwtUtil;
import com.lukemacdonald.profileservice.model.AuthenticationRequest;
import com.lukemacdonald.profileservice.model.Doctor;
import com.lukemacdonald.profileservice.model.User;
import com.lukemacdonald.profileservice.model.Verification;
import com.lukemacdonald.profileservice.service.MapValidationErrorService;
import com.lukemacdonald.profileservice.service.UserService;
import com.lukemacdonald.profileservice.validation.UserValidator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("user")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final UserService userService;

    private final AuthenticationManager authenticationManager;

    private final UserValidator userValidator;

    private final MapValidationErrorService mapValidationErrorService;

    private final JwtUtil jwtUtil;

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
        User newUser = new User(doctor.getEmail(),doctor.getPassword(),doctor.getRole(),
                doctor.getConfirmPassword());

        userValidator.validate(newUser, result);
        userValidator.validate(doctor, result);

        ResponseEntity<?> errorMap = mapValidationErrorService.MapValidationService(result);
        if (errorMap != null) return errorMap;

        userService.saveUser(newUser);

        return new ResponseEntity<>(newUser, HttpStatus.CREATED);
    }

    // Check Verification Table for email existing
    @GetMapping(value ="admin/add/doctor/verification/{email}")
    public ResponseEntity<?>  doctorVerification(@PathVariable("email") String email){

        Map<String, Object> response = new HashMap<>();

        if(userService.verificationExistsByEmail(email)){
            response.put("error","Code Already Sent");
            return new ResponseEntity<>(response, HttpStatus.CONFLICT);
        }

        Verification verification = new Verification(email);
        userService.saveCode(verification);
        response.put("email", verification.getEmail());
        response.put("code", verification.getCode());

        return new ResponseEntity<>(response, HttpStatus.CREATED);

    }

    @PostMapping("/authenticate")
    public ResponseEntity<String> authenticate(@RequestBody AuthenticationRequest request){
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getEmail(),request.getPassword())
        );

        final UserDetails user = userService.getUser(request.getEmail());
        if (user != null){


            return ResponseEntity.ok(jwtUtil.generateToken(user));
        }
        return ResponseEntity.status(400).body("Some Error Has Occurred");

    }

    @GetMapping("/get/id/{id}")
    public User getUserByID(@PathVariable int id) {
        return userService.getUser(id);
    }

    @GetMapping("/get/email/{email}")
    public ResponseEntity<?> getUserByEmail(@PathVariable String email){

        log.info("Getting user with email");

        User user = userService.getUser(email);

        log.info("Getting user with email {} from database: ", user.getFirstName());

        if (user != null){
            return ResponseEntity.ok().body(user);
        }
        return ResponseEntity.status(404).body("User Not Found!");


    }

    @GetMapping(value = "/get/users/{role}")
    public ResponseEntity<List<User>> getUsersByRole(@PathVariable String role){
        return ResponseEntity.ok().body(userService.getUsersByRole(role));
    }

    @GetMapping("/get/name/{id}")
    public ResponseEntity<String> getUserFullName(@PathVariable int id) {
        User user = userService.getUser(id);

        if (user == null) {
            return ResponseEntity.status(404).body("User does not exist in the system!");
        }

        String fullName = String.format("%s %s", user.getFirstName(), user.getLastName());
        return ResponseEntity.ok(fullName);
    }

    @PutMapping(value="/update")
    public ResponseEntity<?> UpdateUser(@RequestBody User update) {

        User user = userService.getUser(update.getEmail());

        System.out.println(user.getFirstName());

        if (userService.getUser(user.getEmail()) != null) {

            if (update.getFirstName() != null){
                user.setFirstName(update.getFirstName());
            }
            if (update.getLastName() != null){
                user.setLastName(update.getLastName());
            }
            if (update.getDob() != null){
                user.setDob(update.getDob());
            }
            if (update.getPhoneNumber() != null){
                user.setPhoneNumber(update.getPhoneNumber());
            }
            return ResponseEntity.ok().body(userService.saveUser(user));
        }
        else {
            return ResponseEntity.status(404).body("User does not exist in the system!");
        }
    }

    @DeleteMapping(value = "/remove/{email}")
    public ResponseEntity<String> removeUserByEmail(@PathVariable String email){
        User user = userService.getUser(email);
        if (user == null){
            return ResponseEntity.status(404).body("User does not exist in the system!");
        }
        userService.deleteUser(user);
        return ResponseEntity.ok().body("Successfully deleted");
    }
}
