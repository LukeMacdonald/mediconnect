package com.lukemacdonald.profileservice.service;

import com.lukemacdonald.profileservice.model.AuthenticationRequest;
import com.lukemacdonald.profileservice.model.User;
import com.lukemacdonald.profileservice.model.Verification;
import com.lukemacdonald.profileservice.model.enums.Role;
import com.lukemacdonald.profileservice.repository.UserRepo;
import com.lukemacdonald.profileservice.repository.VerificationRepo;
import jakarta.ws.rs.NotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Transactional
@Slf4j
@Service
public class UserServiceImpl implements UserService {

    private final UserRepo userRepo;

    private final VerificationRepo verificationRepo;

    private final PasswordEncoder passwordEncoder;

    @Override
    public User saveUser(User user) {
        log.info("Saving new user {} to database: ", user.getEmail());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepo.save(user);
    }

    @Override
    public User getUser(String email) {
        try {
            // Validate email
            if (email == null || email.trim().isEmpty()) {
                throw new IllegalArgumentException("Email cannot be null or empty");
            }

            log.info("Getting user with email {} from database: ", email);
            User user = userRepo.findByEmail(email);

            if (user == null) {
                throw new NotFoundException("User not found with email: " + email);
            }

            return user;

        } catch (IllegalArgumentException e) {
            // Handle validation errors
            log.error("Invalid argument: {}", e.getMessage());
            throw e; // Rethrow the exception if needed or handle it accordingly

        } catch (NotFoundException e) {
            // Handle the case where the user is not found
            log.error("User not found: {}", e.getMessage());
            throw e; // Rethrow the exception if needed or handle it accordingly

        } catch (Exception e) {
            // Handle other unexpected exceptions
            log.error("An unexpected error occurred: {}", e.getMessage());
            throw new RuntimeException("An unexpected error occurred", e); // Rethrow or handle accordingly
        }
    }

    @Override
    public User getUser(int id) {
        try {
            // Validate id
            if (id <= 0) {
                throw new IllegalArgumentException("Invalid user ID");
            }

            log.info("Getting user with id {} from database: ", id);
            User user = userRepo.findById(id);

            if (user != null) {
                return user;
            } else {
                throw new NotFoundException("User not found with ID: " + id);
            }

        } catch (IllegalArgumentException e) {
            // Handle validation errors
            log.error("Invalid argument: {}", e.getMessage());
            throw e; // Rethrow the exception if needed or handle it accordingly

        } catch (NotFoundException e) {
            // Handle the case where the user is not found
            log.error("User not found: {}", e.getMessage());
            throw e; // Rethrow the exception if needed or handle it accordingly

        } catch (Exception e) {
            // Handle other unexpected exceptions
            log.error("An unexpected error occurred: {}", e.getMessage());
            throw new RuntimeException("An unexpected error occurred", e); // Rethrow or handle accordingly
        }
    }

    @Override
    public User updateUser(User user) {
        log.info("Updating user {} to database: ", user.getEmail());
        return userRepo.save(user);
    }



    @Override
    public boolean validate(AuthenticationRequest request) {
        log.info("Email " + request.getEmail());
        User user = userRepo.findByEmail(request.getEmail());

        if (user == null) {
            throw new NotFoundException("User not found with email: " + request.getEmail());
        }

        return passwordEncoder.matches(request.getPassword(), user.getPassword());
    }

    @Override
    public void deleteUser(User user) {
        userRepo.delete(user);
    }

    @Override
    public List<User> getUsers() {
        log.info("Getting all users from database");
        return userRepo.findAll();
    }

    @Override
    public Verification saveCode(Verification verification){
        log.info("Saving verification code for doctor {} in database",verification.getEmail());
        return verificationRepo.save(verification);
    }
    @Override
    public List<User> getUsersByRole(String role){
        log.info("Getting users with role {} from database: ", role);
        return userRepo.findAllByRole(role);
    }

    @Override
    public Boolean existsByEmail(String email) {
        return userRepo.existsByEmail(email);
    }

    @Override
    public Verification findVerificationByEmail(String email) {
        return verificationRepo.findByEmail(email);
    }

    @Override
    public Boolean verificationExistsByEmail(String email) {
        return verificationRepo.existsByEmail(email);
    }

}
