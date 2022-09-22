package com.example.ndtelemedecine.Controllers;

import com.example.ndtelemedecine.Exception.ApiRequestException;
import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Models.Verification;
import com.example.ndtelemedecine.Repositories.UserRepo;
import com.example.ndtelemedecine.Repositories.VerificationRepo;
import com.example.ndtelemedecine.Service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;

@RestController
@RequiredArgsConstructor
public class AuthenticationApiController {
    private final UserService userService;

    private final VerificationRepo verRepo;

    private final UserRepo userRepo;

    @PostMapping(value="/register")
    public ResponseEntity<User> register(@RequestBody User user) {

        User exists = userRepo.findByEmail(user.getEmail());

        if (exists == null){
            URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("/Register").toUriString());
            return ResponseEntity.created(uri).body(userService.saveUser(user));
        }
        else {
            throw new ApiRequestException("User already exists in system!");
        }
    }

    // Checks Verification For Doctor
    @PostMapping(value = "/verification")
    public String verification(@RequestBody Verification submitted){
        Verification stored = verRepo.findByEmail(submitted.getEmail());
        if(stored == null){
            return "SuperAdmin has Not Approved!";
        }
        if(stored.getCode() == submitted.getCode()){
            return "Codes Matched!";
        }
        else if(stored.getCode() != submitted.getCode()){
            return "Codes Did Not Match!";
        }
        else{
            return "Unknown Issue!";
        }
    }
    // Check Verification Table for email existing
    @PostMapping(value ="/EmailVerificationInTable")
    public String verifyDoctorInVerifTable(@RequestBody Verification submitted){
        Verification stored = verRepo.findByEmail(submitted.getEmail());
        if (stored == null){
            verRepo.save(submitted);
            return "Valid email to store";
        }
        else{
            return "Email exists!";
        }
    }
}
