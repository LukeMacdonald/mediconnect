package com.example.ndtelemedecine.User;

import com.example.ndtelemedecine.User.UserRepo;
import com.example.ndtelemedecine.User.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

public enum Role {
    patient(1),
    doctor(2),
    superuser(3);

    private final int value;

    Role(final int value) {
        this.value = value;
    }

    public int getRoleValue() {
        return this.value;
    }

    public String getRoleName() {
        return this.name();
    }

    @RestController
    public static class UserControllers {

        @Autowired
        private UserRepo userRepo;

        @GetMapping(value = "/")
        public String getPage() {
            return "Welcome";
        }

        @GetMapping(value = "/users")
        public List<User> getUsers() {
            return userRepo.findAll();
        }

        @PostMapping(value = "/save")
        public String saveUser(@RequestBody User user) {
            userRepo.save(user);
            return "Saved...";
        }

        @PostMapping("/register")
        public User Register(@RequestBody User user) {
            return userRepo.save(user);
        }
    }
}
