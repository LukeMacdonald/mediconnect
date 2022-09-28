package com.example.profile_service.service;
import com.example.profile_service.model.User;
import com.example.profile_service.model.Verification;

import java.util.List;
public interface UserService {
    User saveUser(User user);
    User getUser(String email);
    User getUser(int id);

    List<User> getUsers();
    Verification saveCode(Verification verification);




}
