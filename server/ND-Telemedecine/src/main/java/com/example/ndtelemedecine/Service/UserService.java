package com.example.ndtelemedecine.Service;

import com.example.ndtelemedecine.Models.User;

import java.util.List;

public interface UserService {

    User saveUser(User user);

    User getUser(String email);

    List<User> getUsers();
}
