package com.example.ndtelemedecine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.ndtelemedecine.User.UserRepo;
import com.example.ndtelemedecine.User.User;

@RestController
public class APIControllers {
    
    @Autowired
    private UserRepo userRepo;

    @GetMapping(value="/")
    public String mainPage() {
        return "Welcome.";
    }

    @GetMapping(value="/Users")
    public List<User> getUsers() {
        return userRepo.findAll();
    }

    @PostMapping(value="/SaveUser")
    public String saveUser(@RequestBody User user) {
        userRepo.save(user);
        return "Saved user...";
    }
}
