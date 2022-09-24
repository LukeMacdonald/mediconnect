package com.example.profile_service.controller;

import com.example.profile_service.model.User;

import com.example.profile_service.repository.UserRepo;
import com.example.profile_service.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class UserController {
    private final UserRepo userRepo;
    private final UserService userService;

    // Assumed that user has filled in all details
    @PutMapping(value="/update")
    public ResponseEntity<User> UpdateUser(@RequestBody User update) {

        User user = userService.getUser(update.getEmail());

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
            return ResponseEntity.ok().body(userRepo.save(user));
        }
        else {
            throw new UsernameNotFoundException( "User does not exists in system!");
        }
    }
    @GetMapping(value = "/get/name/{id}")
    public ResponseEntity<String> getUserFullName(@PathVariable("id") int id){
        String name = userRepo.findById(id).getFirstName() + " " + userRepo.findById(id).getLastName();
        return ResponseEntity.ok().body(name);
    }
    @GetMapping(value = "/get/{email}")
    public ResponseEntity<User> getUserFromEmail(@PathVariable("email") String email){
        return ResponseEntity.ok().body(userRepo.findByEmail(email));
    }
}
