package com.example.ndtelemedecine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.ndtelemedecine.User.UserRepo;
import com.example.ndtelemedecine.User.Exception.ApiRequestException;
import com.example.ndtelemedecine.User.User;
import com.example.ndtelemedecine.DoctorAvailability.AvailabilityRepo;
import com.example.ndtelemedecine.DoctorAvailability.Availability;

@RestController
public class APIControllers {
    
    @Autowired
    private UserRepo userRepo;
    
    @Autowired
    private AvailabilityRepo availRepo;

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
    
    // Verifies user details
    @GetMapping(value="/LogIn")
    public ResponseEntity<User> LogIn(@RequestBody User user) {
        return new ResponseEntity<User>(userRepo.findByEmailAndPassword(user.getEmail(), user.getPassword()), HttpStatus.OK);
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
}