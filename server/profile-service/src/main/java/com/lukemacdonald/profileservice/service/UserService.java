package com.lukemacdonald.profileservice.service;

import com.lukemacdonald.profileservice.model.User;
import com.lukemacdonald.profileservice.model.Verification;
import com.lukemacdonald.profileservice.model.enums.Role;

import java.util.List;

public interface UserService {

    User saveUser(User user);
    User getUser(String email);
    User getUser(int id);

    void deleteUser(User user);

    List<User> getUsers();

    Verification saveCode(Verification verification);

    List<User> getUsersByRole(String role);

    Boolean existsByEmail(String email);

    Verification findVerificationByEmail(String email);

    Boolean verificationExistsByEmail(String email);
}
