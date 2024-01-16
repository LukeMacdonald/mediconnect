package com.lukemacdonald.profileservice.service;

import com.lukemacdonald.profileservice.model.User;
import com.lukemacdonald.profileservice.model.Verification;
import com.lukemacdonald.profileservice.model.enums.Role;
import com.lukemacdonald.profileservice.repository.UserRepo;
import com.lukemacdonald.profileservice.repository.VerificationRepo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@RequiredArgsConstructor
@Transactional
@Slf4j
@Service
public class UserServiceImpl implements UserService, UserDetailsService {

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
        log.info("Getting user with email {} from database: ", email);
        return userRepo.findByEmail(email);
    }

    @Override
    public User getUser(int id) {
        log.info("Getting user with id {} from database: ", id);
        return userRepo.findById(id);
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

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        // Gets email from the supplied email
        User user  = userRepo.findByEmail(email);
        // Checks email exists
        if(user == null){
            log.error("User Not Found in the Database!");
            throw new UsernameNotFoundException("User not found in the database");
        }
        else{
            log.info("User {} Found in the Database!",email);
        }
        Collection<SimpleGrantedAuthority> authority = new ArrayList<>();
        authority.add(new SimpleGrantedAuthority(user.getRoleAuthority()));
        return new org.springframework.security.core.userdetails.User(user.getEmail(), user.getPassword(),authority);
    }
}
