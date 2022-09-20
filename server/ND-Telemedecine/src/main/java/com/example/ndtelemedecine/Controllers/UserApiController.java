package com.example.ndtelemedecine.Controllers;

import com.example.ndtelemedecine.Exception.ApiRequestException;
import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Repositories.UserRepo;
import com.example.ndtelemedecine.Service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class UserApiController {


    private final UserRepo userRepo;

    private final UserService userService;

    @GetMapping(value="/Users")
    public List<User> getUsers() {
        return userRepo.findAll();
    }

    @GetMapping(value="/GetUser/Email")
    public ResponseEntity<List<User>> getUserByEmail(@RequestBody User user) {
        return new ResponseEntity<>(userRepo.findByEmail(user.getEmail()), HttpStatus.OK);
    }
    @GetMapping(value="/GetUserBy/Email")
    public User getUserObjByEmail(@RequestBody User user) {
        return userRepo.findByEmailAndPassword(user.getEmail(), user.getPassword());
    }

    // Assumed that user has filled in all details
    @PutMapping(value="/UpdateUser")
    public String UpdateUser(@RequestBody User user) {
        System.out.println("Saving user with the following details:");
        System.out.println("Updating user with the following details:");
        System.out.println("Name: " + user.getFirstName() + user.getFirstName());
        System.out.println("Phone Number: " + user.getPhoneNumber());
        System.out.println("DoB: " + user.getDob());
        if (getUserByEmail(user).getBody() != null) {
            // Get that user's role and add to the user to update
            // (Case where logging in does not pass user's role to front-end, but registering can)
            user.setRole(userRepo.findByEmail(user.getEmail()).get(0).getRole().toString());
            user.setID(userRepo.findByEmail(user.getEmail()).get(0).getID());
            System.out.println("User's role is: " + user.getRole());
            userService.saveUser(user);
            //userRepo.save(user);
            return "Saved user...";
        }
        else {
            throw new ApiRequestException("User already exists in system!");
        }
    }

    // Get users by role
    @GetMapping(value="/GetUser/Role")
    public ResponseEntity<List<User>> getUserByRole(@RequestBody User user) {
        return new ResponseEntity<>(userRepo.findByRole(user.getRole()), HttpStatus.OK);
    }

    @GetMapping(value = "/GetUserFullName/{id}")
    public String getUserFullName(@PathVariable("id") int id){
        return (userRepo.findById(id).getFirstName() + " " + userRepo.findById(id).getLastName()) ;
    }
    @GetMapping(value = "/GetUserByEmail/{email}")
    public ResponseEntity<User> getUserFromEmail(@PathVariable("email") String email){
        return new ResponseEntity<>(userRepo.findUserByEmail(email), HttpStatus.OK);
    }
}
