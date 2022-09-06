package com.example.ndtelemedecine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.ndtelemedecine.User.Exception.ApiRequestException;
import com.example.ndtelemedecine.User.*;
import com.example.ndtelemedecine.DoctorAvailability.*;
import com.example.ndtelemedecine.DoctorVerificiation.*;

@RestController
public class APIControllers {
    
    @Autowired
    private UserRepo userRepo;

    private User userFound;
    
    @Autowired
    private AvailabilityRepo availRepo;

    @Autowired
    private VerificationRepo verRepo;

    @GetMapping(value="/")
    public String mainPage() {
        return "Welcome.";
    }

    @GetMapping(value="/Users")
    public List<User> getUsers() {
        return userRepo.findAll();
    }

    // Can be used to check if an email already exists as well. Will always return, even if empty.
    @GetMapping(value="/GetUser/Email")
    public ResponseEntity<List<User>> getUserByEmail(@RequestBody User user) {
        return new ResponseEntity<List<User>>(userRepo.findByEmail(user.getEmail()), HttpStatus.OK);
    }

    @PostMapping(value="/Register")
    public String register(@RequestBody User user) {
        
        if (getUserByEmail(user).getBody().isEmpty()) {
            userRepo.save(user);
            return "Saved user...";
        }
        else {
            throw new ApiRequestException("User already exists in system!");
        }
    }

    // Search whilst verifying for user details and store the found user
    @PostMapping(value="/LogInAttempt")
    public boolean LogInAttempt(@RequestBody User user) {
        Boolean returnVal = false;
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
    @GetMapping(value="/LogIn")
    public ResponseEntity<User> LogIn() {
        return new ResponseEntity<User>(userFound, HttpStatus.OK);
    }

    // Get users by role
    @GetMapping(value="/GetUser/Role")
    public ResponseEntity<List<User>> getUserByRole(@RequestBody User user) {
        return new ResponseEntity<List<User>>(userRepo.findByRole(user.getRole()), HttpStatus.OK);
    }

    // Sets a Availability For Doctor
    @PostMapping(value = "/SetDoctorAvailability")
    public String availability(@RequestBody List<Availability> avail){
        availRepo.saveAll(avail);
        return "Set Doctor Availability";
    }
    // Checks Verification For Doctor
    @PostMapping(value = "/DoctorVerification")
    public String verification(@RequestBody Verification veri){
        Verification veri2 = verRepo.findByEmail(veri.getEmail());
        if(veri2 == null){
            return "SuperAdmin has Not Approved!";
        }
        if(veri2.getCode() == veri.getCode()){
            return "Codes Matched!";
        }
        else if(veri2.getCode() != veri.getCode()){
            return "Codes Did Not Match!";
        }
        else{
            return "Unknown Issue!";
        }
    }
}