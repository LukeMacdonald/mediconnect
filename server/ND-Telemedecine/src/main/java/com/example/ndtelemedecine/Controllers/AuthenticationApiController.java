package com.example.ndtelemedecine.Controllers;

import com.example.ndtelemedecine.Models.Verification;
import com.example.ndtelemedecine.Repositories.VerificationRepo;
import com.example.ndtelemedecine.Exception.ApiRequestException;
import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class AuthenticationApiController {
    @Autowired
    private VerificationRepo verRepo;
    @Autowired
    private UserRepo userRepo;

    private User userFound;

    @PostMapping(value="/Register")
    public String register(@RequestBody User user) {
        System.out.println("Saving user with the following details:");
        System.out.println("Email: " + user.getEmail());
        System.out.println("Password: " + user.getPassword());
        User check = userRepo.findUserByEmail(user.getEmail());
        if (check==null){
            userRepo.save(user);
            return "Saved user...";
        }
        else {
            throw new ApiRequestException("User already exists in system!");
        }
    }
    @PostMapping(value="/LogInAttempt")
    public boolean LogInAttempt(@RequestBody User user) {
        boolean returnVal = false;
        if (userRepo.findByEmailAndPassword(user.getEmail(), user.getPassword()) != null){
            userFound = userRepo.findByEmailAndPassword(user.getEmail(), user.getPassword());
            if (userFound.getFirstName() != null){
                returnVal = true;
            }
        }
        else{
            throw new ApiRequestException("User does not exist");
        }
        return returnVal;
    }
    // Returns current user

    @GetMapping(value="/LogIn/{email}")
    public ResponseEntity<User> LogIn(@PathVariable("email") String email) {
        User user = userRepo.findUserByEmail(email);
        return new ResponseEntity<>(user, HttpStatus.OK);
    }
    // Checks Verification For Doctor

    @PostMapping(value = "/DoctorVerification")
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
}
