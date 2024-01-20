package com.lukemacdonald.profileservice.controller;

import com.lukemacdonald.profileservice.model.AuthenticationRequest;
import com.lukemacdonald.profileservice.model.Doctor;
import com.lukemacdonald.profileservice.model.User;
import com.lukemacdonald.profileservice.model.Verification;
import com.lukemacdonald.profileservice.service.MapValidationErrorService;
import com.lukemacdonald.profileservice.service.UserService;
import com.lukemacdonald.profileservice.validation.UserValidator;
import jakarta.ws.rs.NotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.Email;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("user")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final UserService userService;


    private final UserValidator userValidator;

    private final MapValidationErrorService mapValidationErrorService;

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
    @GetMapping(value ="/admin/create-verification")
    public ResponseEntity<?>  doctorVerification(@RequestParam("email") String email){

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
        try{
            boolean validate = userService.validate(request);
            if (validate){
                return ResponseEntity.status(200).body("Login Correct!");
            }
            else {
                return ResponseEntity.status(204).body("Password Incorrect");
            }
        } catch (NotFoundException e){
            return ResponseEntity.status(204).body(e.getMessage());
        } catch (Exception e){
            return ResponseEntity.status(400).body("Some Error Has Occurred");
        }



    }

    @GetMapping("/id")
    public ResponseEntity<?> getUserByID(@RequestParam int id) {
        try {
            // Validate ID
            if (id <= 0) {
                return ResponseEntity.badRequest().body("Invalid user ID");
            }

            User user = userService.getUser(id);

            return ResponseEntity.ok().body(user);

        } catch (IllegalArgumentException e) {
            // Handle validation errors
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (NotFoundException e) {
            // Handle the case where the user is not found
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (Exception e) {
            // Handle other unexpected exceptions
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An unexpected error occurred");
        }
    }

    @GetMapping("/email")
    public ResponseEntity<?> getUserByEmail(@RequestParam @Email String email) {
        try {

            User user = userService.getUser(email);

            if (user != null) {
                return ResponseEntity.ok().body(user);
            }

            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User Not Found!");

        } catch (IllegalArgumentException e) {
            // Handle validation errors
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (NotFoundException e) {
            // Handle the case where the user is not found
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (Exception e) {
            // Handle other unexpected exceptions
            e.printStackTrace(); // Log the exception for further analysis
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An unexpected error occurred");
        }
    }

    @GetMapping(value = "/users")
    public ResponseEntity<List<User>> getUsersByRole(@RequestParam String role){
        return ResponseEntity.ok().body(userService.getUsersByRole(role));
    }

    @GetMapping("/name")
    public ResponseEntity<String> getUserFullName(@RequestParam int id) {
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
            return ResponseEntity.ok().body(userService.updateUser(user));
        }
        else {
            return ResponseEntity.status(404).body("User does not exist in the system!");
        }
    }

    @DeleteMapping(value = "/remove")
    public ResponseEntity<String> removeUserByEmail(@RequestParam String email){
        User user = userService.getUser(email);
        if (user == null){
            return ResponseEntity.status(404).body("User does not exist in the system!");
        }
        userService.deleteUser(user);
        return ResponseEntity.ok().body("Successfully deleted");
    }
}
