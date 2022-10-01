package com.example.profile_service.service;
import com.example.profile_service.model.Verification;
import com.example.profile_service.repository.UserRepo;
import com.example.profile_service.model.User;
import com.example.profile_service.repository.VerificationRepo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


@RequiredArgsConstructor
@Transactional
@Slf4j
@Service
public class UserServiceImpl implements UserService, UserDetailsService {

    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;

    private final VerificationRepo verificationRepo;


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

    @Override
    public User saveUser(User user) {
        log.info("Saving new user {} to database: ", user.getEmail());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepo.save(user);
    }

    @Override
    public User getUser(String email) {
        log.info("Getting user {} from database: ", email);
        return userRepo.findByEmail(email);
    }
    @Override
    public User getUser(int id) {
        log.info("Getting user with {} from database: ", id);
        return userRepo.findById(id);
    }

    @Override
    public List<User> getUsers() {
        log.info("Getting All users from database: ");
        return userRepo.findAll();
    }
    @Override
    public Verification saveCode(Verification verification){
        log.info("Saving verification code for doctor {} in database",verification.getEmail());
        return verificationRepo.save(verification);
    }


}