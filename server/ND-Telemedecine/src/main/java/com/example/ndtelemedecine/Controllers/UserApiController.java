package com.example.ndtelemedecine.Controllers;

import com.example.ndtelemedecine.Exception.ApiRequestException;
import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Repositories.UserRepo;
import com.example.ndtelemedecine.Service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class UserApiController {
    private final UserRepo userRepo;
    private final UserService userService;

    @GetMapping("/admin/users")
    public ResponseEntity<List<User>> getUsers(){
        return ResponseEntity.ok().body(userService.getUsers());
    }
    // Assumed that user has filled in all details
    @PutMapping(value="/user/update")
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
            throw new ApiRequestException("User already exists in system!");
        }
    }
    @GetMapping(value = "/user/get/name/{id}")
    public ResponseEntity<String> getUserFullName(@PathVariable("id") int id){
        String name = userRepo.findById(id).getFirstName() + " " + userRepo.findById(id).getLastName();
        return ResponseEntity.ok().body(name);
    }
    @GetMapping(value = "/user/get/{email}")
    public ResponseEntity<User> getUserFromEmail(@PathVariable("email") String email){
        return ResponseEntity.ok().body(userRepo.findByEmail(email));
    }
}
