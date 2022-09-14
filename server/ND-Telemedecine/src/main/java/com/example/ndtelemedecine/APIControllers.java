package com.example.ndtelemedecine;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.ndtelemedecine.DoctorAvailability.*;
import com.example.ndtelemedecine.User.UserRepo;
import com.example.ndtelemedecine.User.User;
import com.example.ndtelemedecine.DoctorVerificiation.*;
import com.example.ndtelemedecine.Exception.ApiRequestException;

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
        System.out.println("Saving user with the following details:");
        System.out.println("Email: " + user.getEmail());
        System.out.println("Password: " + user.getPassword());
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

    // Assumed that user has filled in all details 

    @PostMapping(value="/UpdateUser")
    public String UpdateUser(@RequestBody User user) {
        System.out.println("Saving user with the following details:");
        System.out.println("Updating user with the following details:");
        System.out.println("Name: " + user.getFirstName() + user.getFirstName());
        System.out.println("Phone Number: " + user.getPhoneNumber());
        System.out.println("DoB: " + user.getDob());
        if (!getUserByEmail(user).getBody().isEmpty()) {
            
            // Get that user's role and add to the user to update 
            // (Case where logging in does not pass user's role to front-end, but registering can)
            user.setRole(userRepo.findByEmail(user.getEmail()).get(0).getRole().toString());
            user.setID(userRepo.findByEmail(user.getEmail()).get(0).getID());
            System.out.println("User's role is: " + user.getRole());
            
            userRepo.save(user);
            return "Saved user...";
        }
        else {
            throw new ApiRequestException("User already exists in system!");
        }
    }

    // Get users by role
    @GetMapping(value="/GetUser/Role")
    public ResponseEntity<List<User>> getUserByRole(@RequestBody User user) {
        return new ResponseEntity<List<User>>(userRepo.findByRole(user.getRole()), HttpStatus.OK);
    }

    // Sets a Availability For Doctor
    @PostMapping(value = "/SetMultipleDoctorAvailability")
    public String availability(@RequestBody List<Availability> avail){
        availRepo.saveAll(avail);
        return "Set Doctor Availability";
    }
    // Sets a Availability For Doctor
    @PostMapping(value = "/SetDoctorAvailability")
    public String availability(@RequestBody Availability avail){
        String message;
        if(avail.getday_of_week() > 7 || avail.getday_of_week() < 0){
            message = "Incorrect Day of Week Entry!";
        }
        else {
            availRepo.save(avail);
            message = "Availability Set!";
        }
        return message;
    }
    // Sets a Availability For Doctor
    @GetMapping(value = "/GetAllDoctorAvailability")
    public List<Availability> doctorsAvailability(){
        userFound = new User();
        userFound.setID(123);
        return availRepo.findByDoctorId(userFound.getID());
    }

    @GetMapping(value = "/GetAllDoctorsAvailabilities")
    public List<Availability> getDoctorsAvailabilities(){
        List<Availability> allAvailabilities = new ArrayList<>();
        for(int i = 1;i < 7;i++){
            allAvailabilities.addAll(availRepo.findBydayOfWeek(i));
        }
        return allAvailabilities;
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

    // Get the users full name from id
    @GetMapping(value = "/GetUserFullName/{id}")
    public String getUserFullName(@PathVariable("id") int id){
        return (userRepo.findById(id).getFirstName() + " " + userRepo.findById(id).getLastName()) ;
    }

}